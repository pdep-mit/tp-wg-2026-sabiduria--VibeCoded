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
		planificador.desaparecer(objeto)
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
	method spawnTimer(objeto){
		game.schedule(azar.numeroEntre(5000,12000), {objeto.spawn()})
	}

	method desaparecer(objeto){
		game.schedule(objeto.tiempoDesaparicion(), {
			if (game.hasVisual(objeto)) { //Si la basura está en el mapa
				game.removeVisual(objeto) 
				self.spawnTimer(objeto)
			}
		})
	}
}
