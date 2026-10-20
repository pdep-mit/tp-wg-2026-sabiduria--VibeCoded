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
        alguien.ganarDinero( self.valorItems(alguien) )
        alguien.items_recolectados().clear()
        alguien.inventario(0)
    }

    method valorItems(persona) = persona.items_recolectados().sum({ item => item.valor() * bonus })

    method estadoInicial(){
        bonus = 1
    }
}