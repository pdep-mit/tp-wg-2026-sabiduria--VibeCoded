import generador.*
import movimientos.*
import personajes.*

/*
==Propuestas de ataques del jefe:
-> Se ilumina toda una linea de celdas, despues de un tiempo se recibe daño si el jugador está parada en ellas
-> Algun elemento que se mueva estilo juego de la viborita, movimiento random, si toca al jugador se pierde 1 vida
-> Aparecen paredes u objetos que no permiten pararse en esa(s) celda(s), dificultando esquivar los otros ataques
*/

class Casilla {
	var property position
	var property image = "aviso.png"
	method alColisionarCon(jugador){}
}

object ataques{
    method comenzar(){
        game.onTick(5500, "timerAtaques", {self.elegirAtaque()})
    }
    
    method elegirAtaque(){
        //Bueno como hay uno solo llamo a ese
        ataqueRecto.seleccionarCeldas()
        ponerTentaculos.comenzarAtaque()
    }

    method detenerAtaques(){
        game.removeTickEvent("timerAtaques")
    }
}

object ataqueRecto{
    const tiempoAviso = 2000
    const tiempoExplosion = 500
    //Supongamos que solo es horizontal

    method seleccionarCeldas(){
        //Como solo es horizontal ubica en columnas
        const ySeleccionada = (0 .. movimiento.techo()-2).anyOne()
        const filaDeCeldasSeleccionadas = (0 .. game.width() - 1).map({ coordenada => new Casilla(position = game.at(coordenada, ySeleccionada))})
        filaDeCeldasSeleccionadas.forEach({celda => game.addVisual(celda)})
		game.schedule(tiempoAviso, {self.explotar(filaDeCeldasSeleccionadas, ySeleccionada)})
    }

    method explotar(celdas, fila){
		celdas.forEach({ celda => celda.image("explosion.gif")})
		const posicionJugador = jugador.position()
		if (posicionJugador.y() == fila) jugador.recibirDanio(1)
		game.schedule(tiempoExplosion, { celdas.forEach({ celda => game.removeVisual(celda)})})
	}
}

//object ataqueViborita inherits Ataque{}
class Tentaculo{
    var property position
    var property hizoDanio = false
    method image() = "tentaculoOnda.gif"

    method alColisionarCon(alguien){
        if(!hizoDanio) {
            hizoDanio = true
            alguien.recibirDanio(1)
            //game.say(alguien, "OUCH!")
        }

    }
}
object ponerTentaculos {
    var property cantTentaculos = 5
    const property tiempoEnPantalla = 3000
    const tiempoAviso = 1500
    //const tiempoPausa = 8000
    //game.schedule(tiempoAviso, {self.aparecerTentaculos()})
    method comenzarAtaque(){
        self.aparecerTentaculos()
    }
    method aparecerTentaculos(){
        cantTentaculos.times({i => self.crearTentaculo()})
    }

    method crearTentaculo(){
        const posRandom = self.obtenerPosicion()

        const aviso= new Casilla(position = posRandom)
        game.addVisual(aviso)
        game.schedule(tiempoAviso, {
            if (game.hasVisual(aviso)) {
                game.removeVisual(aviso)
            }
        
            const tentaculo = new Tentaculo(position = posRandom)
            game.addVisual(tentaculo)
            game.schedule(tiempoEnPantalla, {
                if (game.hasVisual(tentaculo)) {
                    game.removeVisual(tentaculo)
                }
            })
        })
        
    }

    method obtenerPosicion(){
        const largoDelTablero = (0 .. game.width() - 3)
		const altoDelTablero = (0 .. movimiento.techo()-2)

		const x = largoDelTablero.anyOne() //Coordenada random en X
	    const y = altoDelTablero.anyOne() //Coordenada random en Y

	    const celdaRandom = game.at(x, y)
	    if (game.getObjectsIn(celdaRandom).isEmpty()) {
            return celdaRandom
	    } else {
            return self.obtenerPosicion()
        }
    }
}