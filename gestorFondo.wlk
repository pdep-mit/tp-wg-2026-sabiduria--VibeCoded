import ataquesJefe.* 
import generador.* 


object pantallaJuego{
	method image() = "fondo3.jpg"
	const property position = game.origin()
	method aplicarFondo(){
		gestorFondo.actualizarFondo(self)
	}
}

object pantallaDerrota{
	method image() = "fondoDerrota.png"
	const property position = game.origin()
	method aplicarFondo(){
		self.terminarJuego()
		gestorFondo.actualizarFondo(self)

	}

	method terminarJuego()
	{
        planificador.pausarBasura()
        ataques.detenerAtaques()
		game.allVisuals().forEach({
            visual => game.removeVisual(visual)
        })
        gestorFondo.actualizarFondo(self)
        console.println("Juego terminado")
        
    }

}

object pantallaVictoria{
	method image() = "fondo.png"
	method aplicarFondo(){
		gestorFondo.actualizarFondo(self)
	}

}

object gestorFondo{
	var property fondo = pantallaJuego

	method actualizarFondo(nuevoPantalla)
    // todo objeto de pantalla se trata por igual
    {
		fondo = nuevoPantalla
		self.desplegarFondo()
	}

	method desplegarFondo(){
		game.boardGround(fondo.image())
	}

}



