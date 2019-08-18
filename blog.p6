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
    with Person.^load(:name($author)) {
        .say with .posts.create: :$title, :$body
    } else {
        die "Could not find $author"
    }
}

multi MAIN("list-posts") {
    .say for Post.^all
}