use Red;
use Post;

unit model Tag;

has Str $.name  is id;
has     @.post-tags is relationship({ .tag-id }, :model<PostTag> );

method posts { @.post-tags>>.post }