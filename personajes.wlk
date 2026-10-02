import movimientos.*
class Personaje {
	var property position 
	var property image
}
object jugador inherits Personaje (position= game.center(), image= "player.png") {
	var property items_recolectados = []
	var property inventario = 0
	var property capacidadInventario = 4 // inicialmente solo puede llevar 4 bolsas de basura
	var property dinero = 0

	method movimiento(){
    	keyboard.left().onPressDo({ movimiento.mover(self, moverIzq) })
		keyboard.right().onPressDo({ movimiento.mover(self, moverDer) })
		keyboard.up().onPressDo({ movimiento.mover(self, moverArriba) })
		keyboard.down().onPressDo({ movimiento.mover(self, moverAbajo) })
		keyboard.a().onPressDo({movimiento.mover(self,moverDiagonal)})
  	}

   method recolectarItem(item){
        self.inventario( self.inventario() + 1)
        self.items_recolectados().add(item)

    }

    method valorItemsRecolectados(){
        return self.items_recolectados().map({item => item.valor()}).sum()
    }
}

//const jugador = new Personaje(position = game.at(10,0), image= "player.png") 