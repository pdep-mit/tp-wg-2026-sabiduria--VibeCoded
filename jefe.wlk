/*La idea es que aparezca despues de un tiempo (1min por ejemplo), el jugador tenga que recoger y vender todo lo que pueda en ese tiempo
para estar preparado para el enfrentamiento

Cuando aparezca el jefe desaparece el vendedor, no pueden comprarse mejoras, sigue apareciendo basura que debe ser arrojada para dañar al jefe

El jugador dispone de n vidas, cada ataque certero del jefe baja 1. Al llegar a 0 pierde la partida

El jefe ocasionalmente aparecerá en alguna parte del borde superior de la pantalla, momento en el que el jugador lo atacará

El jugador no puede tocar al jefe (o si, pero seria muy facil golpearlo con la basura arrojada, sin necesidad de apuntar). Estará alejado siempre minimo 2 casillas

==Propuestas de ataques del jefe:
-> Se ilumina toda una linea de celdas, despues de un tiempo se recibe daño si el jugador está parada en ellas
-> Algun elemento que se mueva estilo juego de la viborita, movimiento random, si toca al jugador se pierde 1 vida
-> Aparecen paredes u objetos que no permiten pararse en esa(s) celda(s), dificultando esquivar los otros ataques
*/

object jefe{
    const hitBox = 5 //El "ancho" del jefe, es un sprite mas bien alargado para que el jugador tenga que alinearse para pegarle  
    var property vida = 10
    method image() = "jefe.png"
    var property position = game.at(5, game.height() - 2)

    method atacar(){ /*COMPLETAR*/}

    method recibirDanio(cantidad){
        vida = vida - cantidad
        if (vida <= 0) self.morir()
    }

    method morir(){/*COMPLETAR*/}

}