//Archivo para manejar a todos los objetos por si existen otros ademas de la basura

//Cada cierto tiempo (depende del objeto) se regenera en otro lugar. Si se recogio el objeto no vuelve a aparecer hasta que se termine su tiempo de regeneracion.
// Los objetos tienen un tiempo antes de desaparecer.

object azar {
	method numeroEntre(unMinimo, unMaximo) = (unMinimo .. unMaximo).anyOne()
}
object generador{

	method crear(objeto){ //Hace aparecer el objeto en el mapa
		self.ubicar(objeto)
		game.addVisual(objeto)
	}

	method ubicar(objeto){ //Le asigna la celda al objeto

		const largoDelTablero = (0 .. game.width() - 2)
		const altoDelTablero = (0 .. game.height() - 2)

		const x = largoDelTablero.anyOne() //Coordenada random en X
	    const y = altoDelTablero.anyOne() //Coordenada random en Y

	    const celdaRandom = game.at(x, y)
	    if (game.getObjectsIn(celdaRandom).isEmpty()) objeto.position(celdaRandom)
	    else self.ubicar(objeto)
	}
	
}

object planificador {
	method aparecer(objeto) {
		generador.crear(objeto)
		game.schedule(objeto.tiempoDesaparicion(), {self.desaparecer(objeto)})
	}

	method desaparecer(objeto) {
		if (game.hasVisual(objeto)) game.removeVisual(objeto) //Si ya lo habia recogido el jugador no se elimina (por si rompe)
		game.schedule(objeto.tiempoRegeneracion(), {self.aparecer(objeto)}) 
	}
}