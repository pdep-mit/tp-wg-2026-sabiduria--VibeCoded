object cartelCash{
    var property text = "$ 0"
    const property textColor = "FFFFFF"
    var property position = game.at(1, 14) 
    method actualizar(persona){
        text = "$ " + persona.dinero()
    }
    method alColisionarCon(_){}
    method estadoInicial(){
        text = "$ 0"
    }

}

object cartelInv{
    var property text = "0/" 
    var property textColor = "FFFFFF"
    var property position = game.at(2, 14) // posicion a definir 

    method alColisionarCon(_){}
    method actualizar(persona){
        if(persona.items_recolectados().size() == persona.capacidadInventario()){
            textColor = "FF5261"
            text = "" + persona.items_recolectados().size().toString() + " / " + persona.capacidadInventario() + " !!!!"
        }else{
            textColor = "FFFFFF"
            text = "" + persona.items_recolectados().size().toString() + " / " + persona.capacidadInventario()
        }

    }

    method estadoInicial(){
        text = "0"
        textColor = "FFFFFF"
    }
}

object contadorJefe{
    var property text = "BOSS en :" +  timer.toString()
    var property timer = 22
    var property textColor = "FFFFFF" 
    const property position = game.at(4,14)
    

    // method actualizar(persona){
    //     if(timer>0){
    //         timer -= 1
    //         text = "BOSS en :" + timer.toString()
    //     } else {
    //         game.removeVisual(self)
    //     }
    // }
    method alColisionarCon(_){}
    method actualizar(persona){
        if(timer>0){
            timer -= 1
            text ="BOSS en :" +timer.toString()
        } else {
            game.removeTickEvent("contador")
            if(game.hasVisual(self)) game.removeVisual(self)
        }
    }

    method comenzarContador(){
        game.onTick(1000, "contador", {self.actualizar(self)})
    }

    method estadoInicial(){
        timer=22
    }

}
object salud{
    var property position = game.at(0,0)
    var property imagenActual = "corazon3.png" 
    method image() = imagenActual
    method actualizar(persona){
        imagenActual = "corazon" + persona.vidas().toString() + ".png"

    method alColisionarCon(_) {}
    } 
    method alColisionarCon(_){}
}