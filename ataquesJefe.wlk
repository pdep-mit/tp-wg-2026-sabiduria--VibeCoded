/*
==Propuestas de ataques del jefe:
-> Se ilumina toda una linea de celdas, despues de un tiempo se recibe daño si el jugador está parada en ellas
-> Algun elemento que se mueva estilo juego de la viborita, movimiento random, si toca al jugador se pierde 1 vida
-> Aparecen paredes u objetos que no permiten pararse en esa(s) celda(s), dificultando esquivar los otros ataques
*/
import personajes.*
import movimientos.*

class Casilla {
	var property position
	var property image = "aviso.png"
	method alColisionarCon(jugador){}
}

object ataques{
    method comenzar(){
        game.onTick(4000, "timerAtaques", {self.elegirAtaque()})
    }

    method elegirAtaque(){
        //Bueno como hay uno solo llamo a ese
        ataqueRecto.seleccionarCeldas()
    }
}

object ataqueRecto{
    const tiempoAviso = 4000
    const tiempoExplosion = 500

    //Supongamos que solo es horizontal

    method seleccionarCeldas(){
        //Como solo es horizontal ubica en columnas
        const ySeleccionada = (0 .. movimiento.techo()).anyOne()
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
//object ponerParedes inherits Ataque{}