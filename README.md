```
fernando@MBP-de-Fernando blog-schema % perl6 -I../Red -Ilib blog.p6
Usage:
  blog.p6 new-person --name=<Any>
  blog.p6 new-post --author=<Str> --title=<Str>
  blog.p6 list-posts
  blog.p6 comment --author=<Str> --post=<UInt>
  blog.p6 list-comments --post=<UInt>
  blog.p6 list-comments --author=<Str>
fernando@MBP-de-Fernando blog-schema % perl6 -I../Red -Ilib blog.p6 new-person --name=Fernando
Person.new(name => "Fernando")
fernando@MBP-de-Fernando blog-schema % perl6 -I../Red -Ilib blog.p6 new-post --author=Fernando --title="Testing new post"
This is my first post. Just to test it...
Post.new(id => 1, title => "Testing new post", body => "This is my first post. Just to test it...\n", created => DateTime.new(2019,8,18,17,53,4.912947,:timezone(3600)), updated => DateTime.new(2019,8,18,17,53,4.913223,:timezone(3600)), deleted => Any)
fernando@MBP-de-Fernando blog-schema % perl6 -I../Red -Ilib blog.p6 list-posts
Post.new(id => 1, title => "Testing new post", body => "This is my first post. Just to test it...\n", created => DateTime.new(2019,8,18,17,53,4.912947,:timezone(3600)), updated => DateTime.new(2019,8,18,17,53,4.913223,:timezone(3600)), deleted => Any)
fernando@MBP-de-Fernando blog-schema % perl6 -I../Red -Ilib blog.p6 comment --author=Fernando --post=1
Just commenting
Comment.new(body => "Just commenting\n", created => DateTime.new(2019,8,18,17,53,41.94891,:timezone(3600)))
fernando@MBP-de-Fernando blog-schema % perl6 -I../Red -Ilib blog.p6 list-comments --post=1
Comment.new(body => "Just commenting\n", created => DateTime.new(2019,8,18,17,53,41.94891,:timezone(3600)))
fernando@MBP-de-Fernando blog-schema % perl6 -I../Red -Ilib blog.p6 list-comments --author=Fernando
Comment.new(body => "Just commenting\n", created => DateTime.new(2019,8,18,17,53,41.94891,:timezone(3600)))
fernando@MBP-de-Fernando blog-schema %
```