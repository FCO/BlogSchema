use Cromponent;

class Footer does Cromponent {
	has UInt() $.year  = DateTime.now.year;
	has Str()  $.title = "Meu Blog";
	has Str()  $.data  = "&copy; $!year $!title. Todos os direitos reservados.";

	method RENDER {
		Q:to/END/
		<footer>
			<p><&HTML(.data)></p>
		</footer>
		END
	}
}

sub EXPORT() { Footer.^exports }
