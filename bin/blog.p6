#!/usr/bin/env perl6
use Red;
use Schema;

my $*RED-DB = database "SQLite", :database<./blog.db>;

my %*SUB-MAIN-OPTS = :named-anywhere;
my $*RED-DEBUG = so %*ENV<RED_DEBUG>;

sub format-post($_) {
    qq:to/END/
    - { .title }
      Author:    { .author.name }
      Created:   { .created // "something seems wrong" }
      Published: { .published // "not published" }
    { .body.indent: 4 }
    END
}

sub format-person($_) { "- { .name }" }

sub format-tag($_) { "- { .name }" }

multi MAIN("create-db", Bool :$populate) {
    blog-schema.create;
    blog-schema.models.values.map: *.^populate if $populate
}

multi MAIN("new-person", Str :$name!) {
    .say with blog-schema.Person.^create: :$name
}

multi MAIN("list-people") {
    .&format-person.say for blog-schema.Person.^all
}

multi MAIN("new-post", Str :$author!, Str :$title!, Bool :$publish) {
    my $body = $*IN.slurp;
    with blog-schema.Person.^load(:name($author)) {
        .say with .posts.create: :$title, :$body, |(:$publish if $publish)
    } else {
        die "Could not find $author"
    }
}

multi MAIN("publish-post", UInt $post) {
    with blog-schema.Post.^load: $post -> $post {
        $post.publish;
        $post.say;
    } else {
        die "Could not find post $post"
    }
}

multi MAIN("edit-post", UInt $post, Str :$author, Str :$title, Str :$tag) {
    with blog-schema.Post.^load: $post -> $post {
        $post.author = blog-schema.Person.load: :name($author) with $author;
        $post.title  = $title with $title;
        $post.post-tags.create: :tag(blog-schema.Tag.^load: $_) with $tag;

        try $post.^save
    } else {
        die "Could not find post $post"
    }
}

multi MAIN("list-posts", Str :$tag, Bool :$published) {
    my $seq = do with $tag {
        .posts with blog-schema.Tag.^load: $tag
    } else {
        blog-schema.Post.^all
    }
    if $published {
        $seq .= grep: so *.published
    }
    .&format-post.say for $seq<>
}

multi MAIN("comment", Str :$author!, UInt :$post!) {
    my $body = $*IN.slurp;
    with blog-schema.Person.^load(:name($author)) -> $author {
        .say with blog-schema.Post.^load($post).comments.create: :$body, :$author
    } else {
        die "Could not find $author"
    }
}

multi MAIN("list-comments", UInt :$post!) {
    with blog-schema.Post.^load($post) {
        .say for .comments
    } else {
        die "Could not find post id $post"
    }
}

multi MAIN("list-comments", Str :$author!) {
    with blog-schema.Person.^load(:name($author)) {
        .say for .comments
    } else {
        die "Could not find $author"
    }
}

multi MAIN("create-tag", Str $name) {
    blog-schema.Tag.^create: :$name
}

multi MAIN("list-tags", UInt :$post) {
    .&format-tag.say for do with $post {
        .tags with blog-schema.Post.^load: $post
    } else {
        blog-schema.Tag.^all
    }
}

multi MAIN("search-posts", Str $key-word, Bool :$published) {
    my $seq = blog-schema.Post.^all;
    $seq .= grep: so *.published if $published;
    .say for $seq.grep: {
        .title.contains($key-word) || .body.contains($key-word)
    }
}

#multi MAIN("generate") {
#    use Cro::WebApp::Template;
#
#    render-template .get-template, $_ for blog-schema.Post.^all
#}