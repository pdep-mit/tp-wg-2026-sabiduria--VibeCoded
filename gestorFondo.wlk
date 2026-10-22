import ataquesJefe.* 
import generador.* 

object pantallaJuego {
	method image() = "fondo3.jpg"
	const property position = game.origin()
	method aplicarFondo() {
		gestorFondo.actualizarFondo(self)
	}
}

object pantallaDerrota {
	method image() = "fondoDerrota.png"
	const property position = game.origin()
	method aplicarFondo() {
		gestorFondo.actualizarFondo(self)
	}
}

object pantallaVictoria {
	method image() = "fondoVictoria.jpeg" 
	const property position = game.origin()
	method aplicarFondo() {
		gestorFondo.actualizarFondo(self)
	}

}

object gestorFondo {
	var property fondo = pantallaJuego

	method actualizarFondo(nuevoPantalla) {
		fondo = nuevoPantalla
		self.desplegarFondo()
	}

	method desplegarFondo() {
		game.boardGround(fondo.image())
	}
}