use Red;
use BlogConfig;
use Text::Slugify;
use Cromponent;
use Post;

model PostList does Cromponent {
	has UInt $.num = 10;
	has      $.list = Post.^all.grep(*.published);

	method LOAD { PostList.new }

	method RENDER {
		Q:to/END/
		<div class="container">
			<@.list.head(.num).Seq>
				<&HTML(.preview)>
			</@>
		</div>
		END
	}

	method contains($key-word) {
		.title.contains($key-word) && .body.contains($key-word)
	}

	multi method search(::?CLASS:D: Str $key-word) {
		$.clone: :list( $!list.grep(*.contains($key-word)) )
	}

	multi method search(::?CLASS:U: Str $key-word) {
		self.new: :list( Post.^all.grep(*.contains($key-word)) )
	}
}

sub EXPORT { PostList.^exports }
