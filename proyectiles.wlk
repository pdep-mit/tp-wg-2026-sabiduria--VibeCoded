import jefe.*

class Proyectil{ // clase de TESTING -> funciona
    var property image
    var property position
	const property danio = 50
	
	/* Se activa cuando el personaje tira un proyectil
	method alColisionarCon(alguien){
		game.say(alguien, "Me choque con un proyectil")
	} */
/*
	method dispararDer(){
		if(self.position().x()+1 != game.width() -1 && game.hasVisual(self) ){
			game.schedule(500, {
				if(self.position().x()+1 != game.width() - 1){
					self.position( self.position().right(1) )
				 	self.dispararDer()
				} else {
						return
					}
				}
			)
		} else {
			game.removeVisual(self)
		}
	}*/

	method disparar(direccion){
		const siguientePos = direccion.siguiente(self.position())

		if (jefe.esGolpeadoEn(siguientePos)) {
			jefe.recibirDanio(danio)
			game.removeVisual(self)
		} else 
		if (siguientePos.x() >=-2 && siguientePos.x() < game.width()+2 &&
		    siguientePos.y() >=-2 && siguientePos.y() < game.height()+2 &&
		    game.hasVisual(self)) {
			
			game.schedule(250, { 
				if (game.hasVisual(self)) {
					self.position(siguientePos)
					self.disparar(direccion) 
				}
			}
		)
		} else {
			game.removeVisual(self)
		}
	}
    
}
