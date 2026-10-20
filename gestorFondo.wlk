import ataquesJefe.* 
import generador.* 


object pantallaJuego{
	method image() = "fondo3.jpg"
	const property position = game.origin()
}

object pantallaDerrota{
	method image() = "fondoDerrota.png"
	const property position = game.origin()

}

object gestorFondo{
	var fondo = pantallaJuego

    method terminarJuego(){
        planificador.pausarBasura()
        ataques.detenerAtaques()
        game.allVisuals().forEach({
            visual => game.removeVisual(visual)
        }) // no hacer clear()
        self.actualizarFondo(pantallaDerrota)
        console.println("Juego terminado")
        
    }

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



