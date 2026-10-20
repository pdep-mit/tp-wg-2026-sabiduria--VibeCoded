import wollok.game.*
object movimiento {
	var property techo = 15
	
    method mover(personaje, direccion) {
        const nuevaPos = direccion.siguiente(personaje.position())
		const salirDelJefe = personaje.position().y() >= techo -1 && nuevaPos.y() < personaje.position().y()
        if (nuevaPos.x() >= 0 && nuevaPos.x() < game.width() - 1 &&
			nuevaPos.y() >= 0 && nuevaPos.y() < techo - 1 || salirDelJefe) {
		    	personaje.position(nuevaPos)
				personaje.caminar()
				game.schedule(150, {personaje.quedarseQuieto()})
		} else if (personaje.position().y() >= techo ) // arregla bug de personaje quedandose atascado si se encontraba en el techo al momento de aparecer el boss
			{personaje.position( 
				game.at(personaje.position().x(), techo-2)
			)
		}
	}

	method estadoInicial(){
		techo=15
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