import personajes.*
object cartelCash{
    var property text = "$ 0"
    const property textColor = "FFFFFF"
    var property position = game.at(1, 14) // posicion a definir
    method actualizar(persona){
        text = "$ " + persona.dinero()
    }

}

object cartelInv{
    var property text = "0"
    var property textColor = "FFFFFF"
    var property position = game.at(2, 14) // posicion a definir 

    
    method actualizar(persona){
        if(persona.items_recolectados().size() == persona.capacidadInventario()){
            textColor = "FF5261"
            text = "" + persona.items_recolectados().size() + " !!!!"
        }else{
            textColor = "FFFFFF"
            text = "" + persona.items_recolectados().size()
        }

    }
}

object contadorJefe{
    var property text = timer.toString()
    var timer = 60
    var property textColor = "FFFFFF" 
    const property position = game.at(14,5) // cambiar

    method actualizar(persona){
        if(timer>0){
            timer -= 1
            text = timer.toString()
        } else {
            game.removeVisual(self)
        }
    }
}
object salud{
    var property position = game.at(0,0)
    method image() = "corazon" + jugador.vidas() + ".png"
    
}
/*
object vidas {
    var property position = game.at(0,0)
    method image() = "corazon4.png"
}
 object tentaculo{
    method image() = "tentaculoOnda1.gif"
     var property position = game.at(5,1)
 }

     
 object tentaculo1{
    var property position = game.at(10,1)
    method image() = "tentaculoOnda2.gif"
 }*/