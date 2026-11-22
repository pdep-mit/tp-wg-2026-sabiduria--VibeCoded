import configs.*
import ataquesJefe.* 
import generador.* 

object pantallaJuego {
	method image() = "fondo3.jpg"
	const property position = game.origin()
	method aplicarFondo() {
		gestorFondo.actualizarFondo(self)
	}
	method interaccionesEnPantalla() {}

	// TESTING
	method mostarElementos() {}
}

object pantallaDerrota {
	method image() = "fondoDerrota.png"
	const property position = game.origin()
	method aplicarFondo() {
		gestorFondo.actualizarFondo(self)
	}
	method interaccionesEnPantalla() {}

	// TESTING
method mostarElementos() {}
}

object pantallaVictoria {
	method image() = "fondoVictoria.jpeg" 
	const property position = game.origin()
	method aplicarFondo() {
		gestorFondo.actualizarFondo(self)
	}
	method interaccionesEnPantalla() {}

	//TESTING 
	method mostarElementos() {}
}

object pantallaInicial{
	method image() = "HowToTrash_inicio.png"
	method interaccionesEnPantalla(){
		keyboard.i().onPressDo({ self.mostrarObjetivo() })
		keyboard.r().onPressDo({ self.comenzarJuego() })
	}

	method comenzarJuego() {
		config.reiniciar()
	}

	method mostrarObjetivo(){
		gestorFondo.actualizarFondo(pantallaObjetivos)
	}

	// TESTING
	method mostarElementos() {}
}

object pantallaObjetivos{
	method image() = "objetivosScreen.png"

	method interaccionesEnPantalla() {
		explicacion.mostrarExplicaciones()
		keyboard.b().onPressDo( {self.volverAtras()} )
	}

	method volverAtras() {
		explicacion.ocultarExplicaciones()
		gestorFondo.actualizarFondo(pantallaInicial)
	}

	// TESTING
	method mostarElementos() {}
}

object gestorFondo {
	// var property fondo = pantallaJuego
	var property fondo = pantallaInicial

	method actualizarFondo(nuevoPantalla) {
		fondo = nuevoPantalla
		self.desplegarFondo()
	}

	method desplegarFondo() {
		game.boardGround(fondo.image())
		fondo.interaccionesEnPantalla()
	}
}

// OBJETIVOS
object explicacion{
	method text() = "Tienes un tiempo para recolectar basura antes que aparezca el jefe final,\n que es visible en la parte superior izquierda.
	 Durante este tiempo debes recolectar la mayor cantidad\n de basura para luego venderla y comprar mejoras.
	  Compra sabiamente. La primera etapa de mejoras son mejoras\n que te serviran para aumentar ganancias.
	   La siguiente etapa apareceran mejoras que te serviran para el combate con el jefe.
	   Pasa por el vendedor cuando termines de comprar tus mejoras.
	    Elegi bien donde fundir el bolsillo ;) "
	method position() = game.at(7, 9)
	method textColor() = "#FFFFFF"

	method mostrarExplicaciones() { if(game.hasVisual(self)){game.removeVisual(self)} game.addVisual(self) } 
	method ocultarExplicaciones() { game.removeVisual(self) }
}