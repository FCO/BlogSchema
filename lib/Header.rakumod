use Cromponent;
use HeaderLink;

class Header does Cromponent {
	has Str        $.title = "title";
	has Str        $.description = "description";
	has HeaderLink @.links = HeaderLink.^all;

	method RENDER {
		Q:to/END/
		<header>
			<h1><.title></h1>
			<p><.description></p>
			<nav>
				<ul>
					<@.links>
						<&HTML($_)>
					</@>
				</ul>
			</nav>
		</header>
		END
	}
}

sub EXPORT() { Header.^exports }
