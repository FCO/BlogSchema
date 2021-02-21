```
Usage:
  bin/blog.p6 create-db [--populate] -- Creates the database schema. If --populate, populates the DB with sample data.
  bin/blog.p6 new-person --name=<Str> -- Creates a new person
  bin/blog.p6 list-people -- Lists existent people
  bin/blog.p6 new-post --author=<Str> --title=<Str> [--publish] -- Creates a new post. Reads STDIN to get the post's body.
  bin/blog.p6 publish-post <post> -- Publishes a given post.
  bin/blog.p6 edit-post <post> [--author=<Str>] [--title=<Str>] [--tag=<Str>] -- Edits a given post.
  bin/blog.p6 list-posts [--tag=<Str>] [--published] -- Lists all the posts or all posts with a given tag. It can filter only the published posts.
  bin/blog.p6 comment --author=<Str> --post=<UInt> -- Adds a new comment.
  bin/blog.p6 list-comments --post=<UInt> -- Lists all comments. Filter by post.
  bin/blog.p6 list-comments --author=<Str> -- Lists all comments. Filter by author
  bin/blog.p6 create-tag <name> -- Creates a new tag
  bin/blog.p6 list-tags [--post=<UInt>] -- Lists all tags. Filter by post.
  bin/blog.p6 search-posts <key-word> [--published] -- Searches by a post.
```

It uses a few models to describe a DB schema for a blog.

- [Person](https://github.com/FCO/BlogSchema/blob/master/lib/Person.pm6)
  Describes a person, it could be a Post's author or a Comment's author.
  
- [Post](https://github.com/FCO/BlogSchema/blob/master/lib/Post.pm6)
  Describes a post, it's related to `Person` throw the `author` relationship,
  `Comment` throw the `comments` relationship
  and a N-M relationship for `Tag` (using N-1 `post-tags`) called `tags`.
  
- [Tag](https://github.com/FCO/BlogSchema/blob/master/lib/Tag.pm6)
  Describes a tag. It has a N-M relationship (using N-1 `post-tags`) called `posts`.

- [Comment](https://github.com/FCO/BlogSchema/blob/master/lib/Comment.pm6)
  Describes a comment. It's related to a `Post` (`post`) and to a `Person` (`author`).
  
It also has a script used to interact with the DB.