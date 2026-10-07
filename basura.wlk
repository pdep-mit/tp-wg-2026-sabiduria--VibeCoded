import generador.*
import personajes.*


class Basura{
	var property position = game.at(0, 0)
	const property tiempoDesaparicion = 7000 // en ms
	method image()
	method valor()
	method espacio()

	method spawn(){
		generador.crear(self)
	}
	method esRecolectadoPor(jugador){
		if(game.hasVisual(self)) {
			game.removeVisual(self)
			planificador.spawnTimer(self)
		}
	}

	method alColisionarCon(jugador) { jugador.recolectarItem(self)}
}

object botella inherits Basura {
	override method image() = "botella.png"
	override method valor() = 50
	override method espacio() = 1
}

object caja inherits Basura {
	override method image() = "caja.png"
	override method valor() = 50
	override method espacio() = 2
}

object papel inherits Basura {
	override method image() = "papel.png"
	override method valor() = 50
	override method espacio() = 1
}