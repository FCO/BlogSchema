use Red;
use BlogConfig;

unit model Post is rw;

has UInt        $.id        is serial;
has UInt        $!author-id is referencing{ :model<Person>, :column<id> };
has Str         $.title     is column{ :unique } is rw;
has Str         $.body      is column;
has DateTime    $.created   is column .= now;
has DateTime    $.updated   is column .= now;
has DateTime    $.deleted   is column{ :nullable };
has DateTime    $.published is column{ :nullable };
has             $.author    is relationship({ .author-id }, :model<Person> );
has             @.comments  is relationship({ .post-id   }, :model<Comment>);
has             @.post-tags is relationship({ .post-id   }, :model<PostTag>);
has Str         $.template  is column{ :nullable };

method is-published {
    !self.deleted.defined and self.published.defined
}

method delete {
    self.deleted = DateTime.now;
    self.^save
}

method publish {
    self.published = DateTime.now;
    self.^save
}

method !update is before-update {
    self.updated = DateTime.now
}

method tags { @.post-tags>>.tag }

method get-template {
    self.template // BlogConfig.default-post-template
}

method ^populate(\post) {
    my $first = post.^create:
            :title( "First blog post"              ),
            :body(  "Very interesting first post"  ),
            :author{ :name("User 1")               },
            :post-tags[:tag{ :name<tag1>          }],
    ;
    post.^create:
            :title( "Second blog post"             ),
            :body(  "Very interesting second post" ),
            :author{ :name("User 1")               },
            :post-tags[:tag{ :name<tag1>          }],
    ;
    post.^create:
            :title( "Third blog post"              ),
            :body(  "Very interesting Third post"  ),
            :author{ :name("User 2")               },
            :post-tags[:tag{ :name<tag2>          }],
    ;
    post.^create:
            :title( "Fourth blog post"             ),
            :body(  "Very interesting fourth post" ),
            :author{ :name("User 3")               },
            :post-tags[:tag{ :name<tag1>          }],
    ;
    $first.publish;
}