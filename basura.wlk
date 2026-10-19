import generador.*
import personajes.*


class Basura{
	var property position = game.at(0, 0) 
	//const property tiempoRegeneracion = 3000 // en ms
	method tiempoRegeneracion() = azar.numeroEntre(3000, 6500)
	const property tiempoDesaparicion = 6500 // en ms
	method image()
	method valor()
	method espacio()

	method spawn(){
		generador.crear(self)
	}
	method esRecolectadoPor(jugador){
		if(game.hasVisual(self)) {
			game.removeVisual(self)
		}
	}

	method alColisionarCon(jugador) {jugador.recolectarItem(self)}
}

class Botella inherits Basura {
	override method image() = "botella.png"
	override method valor() = 50
	override method espacio() = 1
}

class Caja inherits Basura {
	override method image() = "caja.png"
	override method valor() = 50
	override method espacio() = 2
}

class Papel inherits Basura {
	override method image() = "papel.png"
	override method valor() = 50
	override method espacio() = 1
}

class BotellaCara inherits Basura {
	override method image() = "papel.png"
	override method valor() = 75
	override method espacio() = 1
}

class CajaValiosa inherits Basura {
	override method image() = "papel.png"
	override method valor() = 75
	override method espacio() = 1
}