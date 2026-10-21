import gestorFondo.*
import movimientos.*
import vendedor.*
import generador.*
import ataquesJefe.*
import configs.*


/*La idea es que aparezca despues de un tiempo (1min por ejemplo), el jugador tenga que recoger y vender todo lo que pueda en ese tiempo
para estar preparado para el enfrentamiento

Cuando aparezca el jefe desaparece el vendedor, no pueden comprarse mejoras, sigue apareciendo basura que debe ser arrojada para dañar al jefe

El jugador dispone de n vidas, cada ataque certero del jefe baja 1. Al llegar a 0 pierde la partida

El jefe ocasionalmente aparecerá en alguna parte del borde superior de la pantalla, momento en el que el jugador lo atacará

El jugador no puede tocar al jefe (o si, pero seria muy facil golpearlo con la basura arrojada, sin necesidad de apuntar). Estará alejado siempre minimo 2 casillas

*/

object jefe{
    const hitBox = 5 //El "ancho" del jefe, es un sprite mas bien alargado para que el jugador tenga que alinearse en la misma columna para pegarle  
    var property vida = 10
    method image() = if( vida>0 ) "jefe.gif" else "jefeDerrotado.gif"
    var property position = game.at(5, game.height() - 2)
    var estaVivo = true
    const tiempoDeReubicacion = 10000 // tiempo para reubicar el boss
    const tick = game.tick(tiempoDeReubicacion, {self.reubicar()}, true) // este tick se encarga de reubicar al jefe cada tiempoDeReubicacion

    method aparecer() {
        if(not game.hasVisual(self)){
            tick.start() // empieza el tick de reubicacion
            movimiento.techo(self.position().y() - 2)// Por ahora cuando aparece el jefe, el jugador solo va a poder acercarse a 2 celdas de distancia del jefe
            game.addVisual(self)
            ataques.comenzarAtaques()
        }
	}

    method reubicar() {
		position = game.at(azar.numeroEntre(0, game.width() - hitBox), game.height() - 2)
	}

    method esGolpeadoEn(coordenada) = game.hasVisual(self) && coordenada.x().between(position.x(), position.x() + hitBox - 1) && coordenada.y() == self.position().y()

    method alColisionarCon(jugador) { }
    
    method recibirDanio(cantidad){
        vida = vida - cantidad
        if (vida <= 0 && estaVivo) {self.morir() estaVivo=false}
    }
    
    method morir() {
        ataques.detenerAtaques()
        tick.stop()
        movimiento.estadoInicial()
        planificador.pausarBasura()
        game.schedule(1000, {
            if (game.hasVisual(self)) game.removeVisual(self)
            config.victoria()
        })
    }

    method estadoInicial(){
        vida = 10
        estaVivo = true
        tick.stop()
    }

    
}