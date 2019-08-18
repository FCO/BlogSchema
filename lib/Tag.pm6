use Red;

unit model Tag;

has Str $.name  is id;
has     @.posts is relationship({ .tag }, :model<Post> )