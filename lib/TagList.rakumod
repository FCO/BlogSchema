use Cromponent;
use Tag;

class TagList does Cromponent {
	has Str $.title = "Popular tags";
	has     @.tags = Tag.^all;

	method RENDER {
		Q:to/END/
		<section class="tags">
			<h3><.title></h3>
			<ul class="tag-list">
				<@.tags.Seq>
					<&HTML($_)>
				</@>
			</ul>
		</section>
		END
	}
}

sub EXPORT { TagList.^exports }
