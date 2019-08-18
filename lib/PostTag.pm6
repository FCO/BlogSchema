use Red;

unit model PostTag;

has UInt $!id      is id;
has UInt $!post-id is referencing{ :model<Post>, :column<id>   };
has Str  $!tag-id  is referencing{ :model<Tag>,  :column<name> };

has      $.post    is relationship({ .post-id }, :model<Post>);
has      $.tag     is relationship({ .name    }, :model<Tag> );