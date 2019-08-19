#!/usr/bin/env perl6
use Red;
use Person;
use Post;
use Comment;
use Tag;
use PostTag;

my $*RED-DB = database "SQLite", :database<./blog.db>;

Person.^create-table:  :if-not-exists;
Post.^create-table:    :if-not-exists;
Comment.^create-table: :if-not-exists;
Tag.^create-table:     :if-not-exists;
PostTag.^create-table: :if-not-exists;

my %*SUB-MAIN-OPTS = :named-anywhere;
my $*RED-DEBUG = so %*ENV<RED_DEBUG>;


multi MAIN("new-person", :$name!) {
    .say with Person.^create: :$name
}

multi MAIN("new-post", Str :$author!, Str :$title!) {
    my $body = $*IN.slurp;
    with Person.^load(:name($author)) {
        .say with .posts.create: :$title, :$body
    } else {
        die "Could not find $author"
    }
}

multi MAIN("edit-post", UInt $post, Str :$author, Str :$title, Str :$tag) {
    with Post.^load: $post -> $post {
        $post.author = Person.load: :name($author) with $author;
        $post.title  = $title with $title;
        $post.post-tags.create: :tag(Tag.^load: $_) with $tag;

        try $post.^save
    } else {
        die "Could not find post $post"
    }
}

multi MAIN("list-posts", Str :$tag) {
    .say for do with $tag {
        .posts with Tag.^load: $tag
    } else {
        Post.^all
    }
}

multi MAIN("comment", Str :$author!, UInt :$post!) {
    my $body = $*IN.slurp;
    with Person.^load(:name($author)) -> $author {
        .say with Post.^load($post).comments.create: :$body, :$author
    } else {
        die "Could not find $author"
    }
}

multi MAIN("list-comments", UInt :$post!) {
    with Post.^load($post) {
        .say for .comments
    } else {
        die "Could not find post id $post"
    }
}

multi MAIN("list-comments", Str :$author!) {
    with Person.^load(:name($author)) {
        .say for .comments
    } else {
        die "Could not find $author"
    }
}

multi MAIN("create-tag", Str $name) {
    Tag.^create: :$name
}

multi MAIN("list-tags", UInt :$post) {
    .say for do with $post {
        .tags with Post.^load: $post
    } else {
        Tag.^all
    }
}

multi MAIN("search-posts", Str $key-word) {
    .say for Post.^all.grep: {
        .title.contains($key-word) || .body.contains($key-word)
    }
}