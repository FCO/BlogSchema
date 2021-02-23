use Red;
#use JSON::Fast;
unit model BlogConfig ;

has Str $.key   is id;
has Str $.value is column is rw;

multi method get {
    self.^rs.classify: *.key
}

multi method get(Str $key) {
    $.get{ $key }.head.value
}

method required(+@confs) {
    my $not-defined = @confs ⊖ self.^all.grep(*.key ⊂ @confs).map: *.key;
    die "Configuration(s) not defined: { $not-defined.keys.join: ", " }" if $not-defined;
}

method ^populate(\blogConf) {
    blogConf.^create: :key<templates-path>, :value<resources/>;
    blogConf.^create: :key<default-post-template>, :value<default-post-template.crotmp>;
    blogConf.^create: :key<posts-path>, :value<posts>;
}