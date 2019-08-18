#!/usr/bin/env perl6
use Red;
use Person;
use Post;
use Comment;

my $*RED-DB = database "SQLite", :database<./blog.db>;

Person.^create-table:  :if-not-exists;
Post.^create-table:    :if-not-exists;
Comment.^create-table: :if-not-exists;

my %*SUB-MAIN-OPTS = :named-anywhere;

multi MAIN("new-person", :$name!) {
    .say with Person.^create: :$name
}

multi MAIN("new-post", Str :$author!, Str :$title!) {
    my $body = $*IN.slurp;
#    for (@tags (-) Tag.^all.grep(*.name in @tag).map: *.name).keys -> $name {
#        Tag.^create: :$name
#    }
    with Person.^load(:name($author)) {
        .say with .posts.create: :$title, :$body
    } else {
        die "Could not find $author"
    }
}

multi MAIN("list-posts") {
    .say for Post.^all
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