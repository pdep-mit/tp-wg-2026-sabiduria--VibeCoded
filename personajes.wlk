import movimientos.*
import basura.*
import hud.*
import proyectiles.*
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

		// Para mover el jugador manteniendo las teclas. Cada 300 milisengundos se ejecuta la accion de movimiento

		keyboard.a().whilePressedDo({ movimiento.mover(self, moverIzq	)}, 300)
		keyboard.d().whilePressedDo({ movimiento.mover(self, moverDer	)}, 300)
		keyboard.w().whilePressedDo({ movimiento.mover(self, moverArriba)}, 300)
		keyboard.s().whilePressedDo({ movimiento.mover(self, moverAbajo	)}, 300)
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

	// TESTING: Funcion para el combate contra jefes
	method lanzarBasura(){
		if(!items_recolectados.isEmpty())
		{
			const basuraTirar = items_recolectados.anyOne()
			items_recolectados.remove(basuraTirar)
			cartelInv.actualizar(self)
			const proyectil = new Proyectil(image=basuraTirar.image(), position=self.position().right(1))
			game.addVisual(proyectil)
			proyectil.dispararDer()
		} else {
			game.say(self, "No tengo items para tirar")
		}
	}


	method interaccion(){
	keyboard.m().onPressDo({game.say(self, "Tengo $" + self.dinero().toString())})
	keyboard.i().onPressDo({
			game.say(self, "Tengo " + items_recolectados.size().toString() + " items")
		})
	keyboard.f().onPressDo({self.lanzarBasura()})
	}
}

// TODO: la persona que lleva a la fase del jefe
// TODO: el jefe


//const jugador = new Personaje(position = game.at(10,0), image= "player.png") 