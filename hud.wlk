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