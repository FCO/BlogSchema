use Cromponent;
use Post;

class PostCreate does Cromponent {
	has Post $.post;
	has Str  $.title = $!post ?? $!post.title !! Str;
	has Str  $.body  = $!post ?? $!post.body  !! Str;

	multi method LOAD               { self.new }
	multi method LOAD(Int $post-id) { self.new: :post(Post.^load: $post-id) }

	method RENDER {
		Q:to/END/
		<form
			hx-post="<?.post>post-create/<.post.id>/edit</?><!>post-create/create</!>"
			hx-target="main"
			hx-on::after-request="this.reset()"
		>
			<input type="text" name="title" <?.title>value="<.title>"</?>><br>
			<textarea name="body" cols="80" rows="15"><?.body><.body></?></textarea>
			<input type="submit">
		</form>
		END
	}

	method create(Str :$title, Str :$body) is accessible{ :http-method<POST>, :returns-cromponent } {
		Post.^create: :$title, :$body
	}

	method edit(Str :$title, Str :$body) is accessible{ :http-method<POST>, :returns-cromponent } {
		$!post.title = $_ with $title;
		$!post.body  = $_ with $body;
		$!post.^save;
		$!post
	}
}

sub EXPORT { PostCreate.^exports }
