use Red;
use Cromponent;

model HeaderLink does Cromponent {
	has UInt $.id   is id;
	has Str  $.name is unique;
	has Str  $.url  is column;

	method RENDER {
		Q:to/END/
		<li>
			<a
				href="<.url>"
				hx-get="<.url>"
				hx-target="main"
				hx-swap="innerHTML"
			>
				<.name>
			</a>
		</li>
		END
	}

	method ^populate(\link) {
		link.^create: :name<Home>, :url</post-list>;
		link.^create: :name("Create Post"), :url</post-create>;
	}
}

sub EXPORT { HeaderLink.^exports }
