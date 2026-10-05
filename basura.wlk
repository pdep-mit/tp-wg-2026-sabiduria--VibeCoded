import generador.*
import personajes.*


class Basura{
	var property position = game.at(0, 0)
	method image()
	method valor()
	method espacio()

	method spawn(){
		generador.crear(self)
	}
	method esRecolectadoPor(jugador){
		jugador.ganarDinero(self.valor())
		game.removeVisual(self)
		generador.spawnTimer(self)
	}
}

object botella inherits Basura {
	override method image() = "botella.png"
	override method valor() = 4
	override method espacio() = 1
}

object caja inherits Basura {
	override method image() = "caja.png"
	override method valor() = 2
	override method espacio() = 2
}

object papel inherits Basura {
	override method image() = "inv1.gif" //Falta agregar el asset
	override method valor() = 1
	override method espacio() = 1
}