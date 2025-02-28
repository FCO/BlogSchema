# BlogSchema

This is an example of how easy it is to use [Red](https://github.com/FCO/Red) and [Raku](https://raku.org)
to develop a DB schema for a simple blog. It does not serve or generates the blog's pages.
It only creates the database schema and provides introspection into the database.

## Usage:
```
Usage:
  bin/blog create-db [--populate] -- Creates the database schema. If --populate, populates the DB with sample data.
  bin/blog new-person --name=<Str> -- Creates a new person
  bin/blog list-people -- Lists existent people
  bin/blog new-post --author=<Str> --title=<Str> [--publish] -- Creates a new post. Reads STDIN to get the post's body.
  bin/blog publish-post <post> -- Publishes a given post.
  bin/blog edit-post <post> [--author=<Str>] [--title=<Str>] [--tag=<Str>] -- Edits a given post.
  bin/blog list-posts [--tag=<Str>] [--published] -- Lists all the posts or all posts with a given tag. It can filter only the published posts.
  bin/blog comment --author=<Str> --post[=UInt] -- Adds a new comment.
  bin/blog list-comments --post[=UInt] -- Lists all comments. Filter by post.
  bin/blog list-comments --author=<Str> -- Lists all comments. Filter by author
  bin/blog create-tag <name> -- Creates a new tag
  bin/blog list-tags [--post[=UInt]] -- Lists all tags. Filter by post.
  bin/blog search-posts <key-word> [--published] -- Searches by a post.
  bin/blog get-config
  bin/blog get-config <key>
  bin/blog rm-config <key>
  bin/blog set-config <key> <value>
  bin/blog generate
  bin/blog config-wizard
  bin/blog run-web
```

### Fast run:
```
❯ zef install .
===> Staging BlogSchema:ver<0.1>:auth<:github<FCO>>
===> Staging [OK] for BlogSchema:ver<0.1>:auth<:github<FCO>>
===> Testing: BlogSchema:ver<0.1>:auth<:github<FCO>>
===> Testing [OK] for BlogSchema:ver<0.1>:auth<:github<FCO>>
===> Installing: BlogSchema:ver<0.1>:auth<:github<FCO>>

1 bin/ script [blog] installed to:
/Users/fernando/.rakubrew/versions/moar-blead/install/share/perl6/site/bin
❯ blog create-db --populate
❯ blog run-web
adding POST post
adding GET post/<id>
adding POST post-list
adding GET post-list
Listening at http://0.0.0.0:4000
```



## Models:

It uses a few models to describe a DB schema for a blog.

- [Person](https://github.com/FCO/BlogSchema/blob/master/lib/Person.pm6)
  Describes a person, it could be a Post's author or a Comment's author.
  
- [Post](https://github.com/FCO/BlogSchema/blob/master/lib/Post.pm6)
  Describes a post, it's related to `Person` through the `author` relationship,
  `Comment` through the `comments` relationship
  and a N-M relationship for `Tag` (using N-1 `post-tags`) called `tags`.
  
- [Tag](https://github.com/FCO/BlogSchema/blob/master/lib/Tag.pm6)
  Describes a tag. It has a N-M relationship (using N-1 `post-tags`) called `posts`.

- [Comment](https://github.com/FCO/BlogSchema/blob/master/lib/Comment.pm6)
  Describes a comment. It's related to a `Post` (`post`) and to a `Person` (`author`).

- [BlogConfig](https://github.com/FCO/BlogSchema/blob/master/lib/BlogConfig.pm6)
  Stores pairs (key/value) with the blog's configuration.
  
It also has a script used to interact with the DB.
