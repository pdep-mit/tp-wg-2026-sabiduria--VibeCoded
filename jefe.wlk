import movimientos.*
import vendedor.*
import wollok.game.*
import generador.* 

/*La idea es que aparezca despues de un tiempo (1min por ejemplo), el jugador tenga que recoger y vender todo lo que pueda en ese tiempo
para estar preparado para el enfrentamiento

Cuando aparezca el jefe desaparece el vendedor, no pueden comprarse mejoras, sigue apareciendo basura que debe ser arrojada para dañar al jefe

El jugador dispone de n vidas, cada ataque certero del jefe baja 1. Al llegar a 0 pierde la partida

El jefe ocasionalmente aparecerá en alguna parte del borde superior de la pantalla, momento en el que el jugador lo atacará

El jugador no puede tocar al jefe (o si, pero seria muy facil golpearlo con la basura arrojada, sin necesidad de apuntar). Estará alejado siempre minimo 2 casillas

=== FALTA === 
 - Ataques del jefe
*/

object jefe{
    const hitBox = 5 //El "ancho" del jefe, es un sprite mas bien alargado para que el jugador tenga que alinearse en la misma columna para pegarle  
    var property vida = 10
    method image() = "jefe.png"
    var property position = game.at(5, game.height() - 2)

    method aparecer() {
		self.reubicar()
        if(!game.hasVisual(self)) game.addVisual(self)
		game.onTick(15000, "moverJefe", {self.reubicar()})
        //Llamar al activador de timer de los ataques
	}

    // Cumple lo mismo que hacia aparecer() solo que es un loop mientras el jefe este vivo y sea visible
    method actualizarJefe(){
        if(game.hasVisual(self)){
    		game.onTick(15000, "moverJefe", {self.reubicar()
                                                })
        } else {
            vendedor.cerrarNegocio()
            self.reubicar()
            game.addVisual(self)
            movimiento.techo( self.position().y() - 2 ) // Por ahora cuando aparece el jefe, el jugador solo va a poder acercarse a 2 celdas de distancia del jefe
            self.actualizarJefe()
        }
    }

    method reubicar() {
		position = game.at(azar.numeroEntre(0, game.width() - hitBox), game.height() - 2)
	}

    method esGolpeadoEn(coordenada) = game.hasVisual(self) && coordenada.x().between(position.x(), position.x() + hitBox - 1) && coordenada.y() == self.position().y()

    method alColisionarCon(jugador) { }
    
    method recibirDanio(cantidad){
        vida = vida - cantidad
        if (vida <= 0) self.morir()
    }

    method morir(){
        game.removeTickEvent("moverJefe")
        //Remover el timer de los ataques
	    game.removeVisual(self)
        movimiento.techo(15) // vuelve a default
    }

}