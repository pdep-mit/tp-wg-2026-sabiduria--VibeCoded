class Proyectil{ // clase de TESTING -> funciona
    var property image
    var property position

	const property danio = 50
	
	method alColisionarCon(alguien){
		game.say(alguien, "Me choque con un proyectil")
	}

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
	}

	method impactarBala(alguien){
		alguien.vida( alguien.vida() - self.danio() )
	}
    
}
