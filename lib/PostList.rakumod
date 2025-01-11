use Red;
use BlogConfig;
use Text::Slugify;
use Cromponent;
use Post;

model PostList does Cromponent {
	has UInt $.num = 10;
	has      $.list = Post.^all.grep(*.published).head($!num).Seq;

	method LOAD(|) { PostList.new }
	method RENDER {
		Q:to/END/
			<div class="container">
				<@.list>
					<&HTML(.preview)>
				</@>
			</div>
		END
	}
}

sub EXPORT { PostList.^exports }
