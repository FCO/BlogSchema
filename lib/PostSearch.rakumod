use Red;
use BlogConfig;
use Text::Slugify;
use PostList;
use Post;
use Cromponent;

model PostSearch does Cromponent {
	has Str $.input-placeholder = "Search for posts...";
	has Str $.button-label      = "Search";

	method LOAD { PostSearch.new }

	method RENDER {
		Q:to/END/
		<section class="search">
			<form hx-get="/post-search/search" hx-target="main" hx-swap="innerHTML">
				<input type="text" name="query" placeholder="<.input-placeholder>" required>
				<button type="submit"><.button-label></button>
			</form>
		</section>
		END
	}

	method search(:$query) is accessible{:returns-cromponent} {
		PostList.new: :list(Post.^all.grep: { .published && (.title.contains($query) || .body.contains($query)) })
	}
}

sub EXPORT { PostSearch.^exports }
