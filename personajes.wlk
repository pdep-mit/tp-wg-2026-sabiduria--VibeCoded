import movimientos.*
import basura.*
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

		keyboard.a().onPressDo({ movimiento.mover(self, moverIzq) })
		keyboard.d().onPressDo({ movimiento.mover(self, moverDer) })
		keyboard.w().onPressDo({ movimiento.mover(self, moverArriba) })
		keyboard.s().onPressDo({ movimiento.mover(self, moverAbajo) })
		//keyboard.a().onPressDo({movimiento.mover(self,moverDiagonal)})
  	}

    method recolectarItem(item){
		if(self.sinInventario()) {
			game.say(self,"¡Me quedé sin espacio!")
		} else {
				self.inventario(self.inventario() + 1)
        		self.items_recolectados().add(item)
				item.esRecolectadoPor(self)
		}
    }
	
	method sinInventario() = (items_recolectados.size() >= capacidadInventario) 

	method vaciarInventario(){ //Vender
		items_recolectados.clear()
		self.inventario(0)
	}
    method valorItemsRecolectados(){
        return self.items_recolectados().sum({item => item.valor()})
    }

	method ganarDinero(cantidad) {
		dinero+= cantidad
	}

	method interaccion(){
	keyboard.m().onPressDo({game.say(self, "Tengo $" + self.dinero().toString())})
	keyboard.i().onPressDo({
			game.say(self, "Tengo " + items_recolectados.size().toString() + " items")
		})
	}
}

//const jugador = new Personaje(position = game.at(10,0), image= "player.png") 