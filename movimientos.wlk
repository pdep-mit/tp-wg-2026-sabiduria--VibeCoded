import wollok.game.*
object movimiento {
    method mover(personaje, direccion) {
        const nuevaPos = direccion.siguiente(personaje.position())
        if (nuevaPos.x() >= 0 && nuevaPos.x() < game.width() - 1 &&
			nuevaPos.y() >= 0 && nuevaPos.y() < game.height() - 1)
		    personaje.position(nuevaPos)
	}	
}

object moverIzq { 
	method siguiente(position) = position.left(1) 
}

object moverDer { 
	method siguiente(position) = position.right(1) 
}

object moverAbajo { 
	method siguiente(position) = position.down(1) 
}

object moverArriba { 
	method siguiente(position) = position.up(1) 
}

object moverDiagonal{
  method siguiente(position) = position.up(1).right(1)
}