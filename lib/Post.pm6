use Red;

unit model Post is rw;

has UInt        $.id        is serial;
has UInt        $!author-id is referencing{ :model<Person>, :column<id> };
has Str         $.title     is column{ :unique } is rw;
has Str         $.body      is column;
has DateTime    $.created   is column .= now;
has DateTime    $.updated   is column .= now;
has DateTime    $.deleted   is column{ :nullable };
has             $.author    is relationship({ .author-id }, :model<Person> );
has             @.comments  is relationship({ .post-id   }, :model<Comment>);
has             @.post-tags is relationship({ .post-id   }, :model<PostTag>);

method delete {
    $!deleted = now;
    self.^save
}

method update is before-update {
    $!updated .= now
}

method tags { flat @!post-tags.map: *.tag.name }