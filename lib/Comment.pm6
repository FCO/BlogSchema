use Red;

unit model Comment is table<post_comment> is rw;

has UInt     $!id        is serial;
has Str      $.message   is column;
has UInt     $!author-id is referencing{ :model<Person>, :column<id> };
has UInt     $!post-id   is referencing{ :model<Post>,   :column<id> };
has DateTime $.created   is column .= now;
has          $.author    is relationship({ .author-id }, :model<Person>);
has          $.post      is relationship({ .post-id   }, :model<Post>);

method post-author { $!post.author }