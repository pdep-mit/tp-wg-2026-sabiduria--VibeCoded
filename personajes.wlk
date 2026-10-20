import movimientos.*
import basura.*
//import hud.*
import proyectiles.*
/*
class Personaje {
	var property position 
	var property image
}*/
object jugador {
	var property position= game.center()
	var imagenActual = "pjfrente.png" 
	var property items_recolectados = []
	var property inventario = 0
	var property capacidadInventario = 4 // inicialmente solo puede llevar 4 bolsas de basura
	var property dinero = 0
	var property vidas = 3
	var property danio = 1 
	const caminarAnimacion = ["pjcamina.png", "pjcamina1.png"]
	var estaEnMovimiento = false
	
	method image(){
		if (estaEnMovimiento) {
			return imagenActual
		} else {
			return "pjfrente.png"
		}
	}

	method caminar(){
		estaEnMovimiento = true
		imagenActual = caminarAnimacion.anyOne()
	}

	method quedarseQuieto(){
		estaEnMovimiento = false
	}

	method controles(){
		//Teclas para disparar
   		keyboard.right().onPressDo({ self.lanzarBasura(moverDer) })
		keyboard.left().onPressDo({ self.lanzarBasura(moverIzq) })
		keyboard.up().onPressDo({ self.lanzarBasura(moverArriba) })
		keyboard.down().onPressDo({ self.lanzarBasura(moverAbajo) })

		// Para mover el jugador manteniendo las teclas. Cada 300 milisengundos se ejecuta la accion de movimiento

		keyboard.a().whilePressedDo({ movimiento.mover(self, moverIzq	)}, 250)
		keyboard.d().whilePressedDo({ movimiento.mover(self, moverDer	)}, 250)
		keyboard.w().whilePressedDo({ movimiento.mover(self, moverArriba)}, 250)
		keyboard.s().whilePressedDo({ movimiento.mover(self, moverAbajo	)}, 250)
		//keyboard.a().onPressDo({movimiento.mover(self,moverDiagonal)}) No sirve para nada(?
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
	var delayProyectil = false
	const delay = 200
	method lanzarBasura(direccion){
		if(!delayProyectil){
			if(!items_recolectados.isEmpty())
			{
				delayProyectil = true
				const basuraTirar = items_recolectados.anyOne()
				items_recolectados.remove(basuraTirar)
				//cartelInv.actualizar(self)
				const proyectil = new Proyectil(image=basuraTirar.image(), position=self.position())
				game.addVisual(proyectil)
				proyectil.disparar(direccion)
				game.schedule(delay, {delayProyectil = false})
			} else {
				game.say(self, "No tengo items para tirar")
			}
		}
	}

	method interaccion(){
	keyboard.m().onPressDo({game.say(self, "Tengo $" + self.dinero().toString())})
	keyboard.i().onPressDo({
			game.say(self, "Tengo " + items_recolectados.size().toString() + " items")
		})
	//keyboard.f().onPressDo({self.lanzarBasura()})
	}

	method recibirDanio(cantidad){
		vidas = (vidas - cantidad).max(0)
		if (vidas <= 0) { //Posible implementación: cuando quede a 1 de vida, recibir daño le saca medio corazon
			self.morir()
		}
	}

	method morir(){
		game.say(self, "AHHHHHH!") //(?
	}
}

// TODO: la persona que lleva a la fase del jefe
// TODO: el jefe
