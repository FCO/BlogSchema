```
Usage:
  blog.p6 new-person --name=<Any>
  blog.p6 new-post --author=<Str> --title=<Str> [--publish]
  blog.p6 publish-post <post>
  blog.p6 edit-post <post> [--author=<Str>] [--title=<Str>] [--tag=<Str>]
  blog.p6 list-posts [--tag=<Str>] [--published]
  blog.p6 comment --author=<Str> --post=<UInt>
  blog.p6 list-comments --post=<UInt>
  blog.p6 list-comments --author=<Str>
  blog.p6 create-tag <name>
  blog.p6 list-tags [--post=<UInt>]
  blog.p6 search-posts <key-word> [--published]
```