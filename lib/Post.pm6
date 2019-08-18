use Red;

unit model Post is rw;

has UInt        $!id        is serial;
has UInt        $!author-id is referencing{ :model<Person>, :column<id> };
has Str         $.title     is column{ :unique };
has Str         $.body      is column;
has             $.author    is relationship({ .author-id }, :model<Person>);
has Bool        $.deleted   is column  = False;
has DateTime    $.created   is column .= now;
has Set         $.tags      is column{
    :type<string>,
    :deflate{ .keys.join: "," },
    :inflate{ set(.split: ",") }
} = set();
method delete { $!deleted = True; self.^save }