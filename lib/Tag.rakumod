use Red;
use Post;
use PostList;
use Cromponent;

model Tag does Cromponent {
	has Str $.name  is id;
	has     @.post-tags is relationship({ .tag-id }, :model<PostTag> );

	method LOAD(Str $name) { Tag.^load: $name }

	method RENDER {
		Q:to/END/
		<li>
			<a
				href="/tag/<.name>/show"
				hx-get="/tag/<.name>/show"
				hx-target="main"
				hx-swap="innerHTML"
			>
				<.name.tc>
			</a>
		</li>
		END
	}

	method posts { @.post-tags>>.post }

	method show is accessible{:returns-cromponent, :http-method<GET>} {
		PostList.new: :list($.posts)
	}
}
