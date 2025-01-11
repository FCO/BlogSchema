use Cromponent;

class Header does Cromponent {
	has Str $.title = "title";
	has Str $.description = "description";

	method RENDER {
		Q:to/END/
		<header>
			<h1><.title></h1>
			<p><.description></p>
			<nav>
				<ul>
					<li>
						<a
							href="/post_list"
							hx-get="/post_list"
							hx-target="main"
							hx-swap="innerHTML"
						>
							Home
						</a>
					</li>
					<li>
						<a
							href="/sobre"
							hx-get="/sobre"
							hx-target="main"
							hx-swap="innerHTML"
						>
							Sobre
						</a>
					</li>
					<li>
						<a
							href="/contato"
							hx-get="/contato"
							hx-target="main"
							hx-swap="innerHTML"
						>
							Contato
						</a>
					</li>
				</ul>
			</nav>
		</header>
		END
	}
}

sub EXPORT() { Header.^exports }
