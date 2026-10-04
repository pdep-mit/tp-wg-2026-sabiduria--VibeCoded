object negocioMejoras{
    var property bonus = 1 

    method comprarMejora(alguien, mejora){
        if(alguien.dinero() >= mejora.precio()){
            alguien.dinero( alguien.dinero() - mejora.precio() )
            mejora.ventaja(alguien)
            // alguien.aplicarMejora(mejora)
        } else {
            game.say(alguien, "No tengo suficiente plata para esta mejora")
        }
    }

    method venderBasura(alguien){
        // alguien.dinero( alguien.valorItemsRecolectados() )
        alguien.dinero( self.valorItems(alguien) )
        alguien.items_recolectados().forEach({
            item => alguien.items_recolectados().remove(item)
        }) // elimino todos los items de la lista
        alguien.inventario(0)
    }

    method valorItems(persona){
        if(!persona.items_recolectados().isEmpty()){
            return persona.items_recolectados().sum({
                item => item.valor() * bonus
            })
        } else {
            return persona.dinero()
        }
        
    }


}