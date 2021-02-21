use Red;
use JSON::Fast;
unit model BlogConfig ;

has Str $.key   is id;
has Str $.value is column is rw;

multi method get {
    self.^rs.classify: *.key
}

multi method get(Str $key) {
    $.get{ $key }
}

method ^populate(\blogConf) {
    blogConf.^create: :key<default-post-template>, :value<default-post-template.tmp>;
}