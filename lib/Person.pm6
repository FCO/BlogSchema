use Red;

unit model Person is rw;

has UInt $!id            is serial;
has Str  $.name          is column{ :unique };
has      @.posts         is relationship({ .author-id }, :model<Post>   );
has      @.comments      is relationship({ .author-id }, :model<Comment>);

method active-posts { @!posts.grep: not *.deleted }


