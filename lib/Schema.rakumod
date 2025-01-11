use Red;
use Person;
use Post;
use Comment;
use Tag;
use PostTag;
use BlogConfig;

sub blog-schema is export {
    $ = schema(Person, Post, Comment, Tag, PostTag, BlogConfig)
}