```
Usage:
  bin/blog.p6 create-db [--populate]
  bin/blog.p6 new-person --name=<Str>
  bin/blog.p6 list-people
  bin/blog.p6 new-post --author=<Str> --title=<Str> [--publish]
  bin/blog.p6 publish-post <post>
  bin/blog.p6 edit-post <post> [--author=<Str>] [--title=<Str>] [--tag=<Str>]
  bin/blog.p6 list-posts [--tag=<Str>] [--published]
  bin/blog.p6 comment --author=<Str> --post=<UInt>
  bin/blog.p6 list-comments --post=<UInt>
  bin/blog.p6 list-comments --author=<Str>
  bin/blog.p6 create-tag <name>
  bin/blog.p6 list-tags [--post=<UInt>]
  bin/blog.p6 search-posts <key-word> [--published]
```