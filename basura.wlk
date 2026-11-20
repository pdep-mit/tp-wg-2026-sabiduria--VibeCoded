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
	method danio() = 1 //Ahora la basura se encarga de decir cuanto daño hace, por default es 1.

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
	override method danio() = super() + 1 //Hace mas daño por ser de vidrio
}

class Caja inherits Basura {
	override method image() = "caja.png"
	override method valor() = 50
	override method espacio() = 2
	override method danio() = super() + 4 //Por ser mas grande (y ocupar el equivalente a 2 botellas por ejemplo)
}

class Papel inherits Basura {
	override method image() = "papel.png"
	override method valor() = 50
	override method espacio() = 1
}

class BotellaCara inherits Botella {
	override method image() = "botellaCara.png"
	override method valor() = 75
	override method danio() = super() * 2 //multiplicador por ser cara
}

class CajaValiosa inherits Basura {
	override method image() = "cajaValiosa.png"
	override method valor() = 75
	override method espacio() = 1
	override method danio() = super() * 2
}