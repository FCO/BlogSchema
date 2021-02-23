use Red;
use BlogConfig;
use Text::Slugify;

unit model Post is rw;

has UInt        $.id        is serial;
has UInt        $!author-id is referencing{ :model<Person>, :column<id> };
has Str         $.title     is unique;
has Str         $.subtitle  is column = "";
has Str         $.slug      is unique;
has Str         $.body      is column;
has DateTime    $.created   is column .= now;
has DateTime    $.updated   is column .= now;
has DateTime    $.published is column{ :nullable };
has Bool        $.draft     is column = True;
has             $.author    is relationship({ .author-id }, :model<Person> );
has             @.comments  is relationship({ .post-id   }, :model<Comment>);
has             @.post-tags is relationship({ .post-id   }, :model<PostTag>);
has Str         $.template  is column{ :nullable };

method !slugify is before-create {
    $!slug = slugify $!title
}

method is-published {
    !$.draft
            &&  $.published.defined && $.published <= DateTime.now
}

method delete {
    self.deleted = DateTime.now;
    self.^save
}

method publish {
    self.published = DateTime.now;
    self.draft = False;
    self.^save
}

method !update is before-update {
    self.updated = DateTime.now
}

method tags { @.post-tags>>.tag }

method get-template {
    self.template // BlogConfig.get<default-post-template>.head.value
}

method ^populate(\post) {
    my $first = post.^create:
            :title( "First blog post"              ),
            :subtitle("subtitle 1"                 ),
            :body(  "Very interesting first post"  ),
            :author{
                :full-name("User 1"),
                :user-name<user1>,
                :email<a@b.com>,
                :about("Someone that loves to wright"),
            },
            :post-tags[:tag{ :name<tag1>          }],
    ;
    post.^create:
            :title( "Second blog post"             ),
            :subtitle("subtitle 2"                 ),
            :body(  "Very interesting second post" ),
            :author{ :full-name("User 1")          },
            :post-tags[:tag{ :name<tag1>          }],
    ;
    post.^create:
            :title( "Third blog post"              ),
            :subtitle("subtitle 3"                 ),
            :body(  "Very interesting Third post"  ),
            :author{
                :full-name("User 2"),
                :user-name<user2>,
                :email<c@b.com>,
            },
            :post-tags[:tag{ :name<tag2>          }],
    ;
    post.^create:
            :title( "Fourth blog post"             ),
            :subtitle("subtitle 4"                 ),
            :body(  "Very interesting fourth post" ),
            :author{
                :full-name("User 3"),
                :user-name<user3>,
                :email<d@b.com>,
            },
            :post-tags[:tag{ :name<tag1>          }],
    ;
    $first.publish;
}