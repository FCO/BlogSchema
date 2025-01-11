use Red;

unit model Comment is table<post_comment> is rw;

has UInt     $!id        is serial;
has Str      $.body      is column;
has UInt     $!author-id is referencing( *.id, :model<Person> );
has UInt     $!post-id   is referencing( *.id, :model<Post>   );
has DateTime $.created   is column .= now;
has          $.author    is relationship({ .author-id }, :model<Person>);
has          $.post      is relationship({ .post-id   }, :model<Post>);

method post-author { $!post.author }