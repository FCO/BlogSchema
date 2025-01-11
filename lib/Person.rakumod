use Red;

unit model Person is rw;

has UInt $!id            is serial;
has Str  $.full-name     is column;
has Str  $.user-name     is unique;
has Str  $.email         is unique;
has Str  $.about         is column{ :nullable };
has      @.posts         is relationship({ .author-id }, :model<Post>   );
has      @.comments      is relationship({ .author-id }, :model<Comment>);

method active-posts { @!posts.grep: not *.deleted }


