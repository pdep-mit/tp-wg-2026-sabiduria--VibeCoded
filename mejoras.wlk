import negocioMejoras.*

object masInv{
    method image() = "inv1.gif"
    const property precio = 150
    const property descripcion = "Aumenta la capacidad del inventario en 4 lugares"
    method ventaja(persona){
        persona.capacidadInventario( persona.capacidadInventario() + 4 )
    }
}

object masBasura{
    method image() = "masCapacidad.gif"
    const property precio = 160
    const property descripcion = "Se quiere mudar mas gente a esta zona, eso quiere decir que habra mas basura"
    method ventaja(persona){
        // deberia agregar a una lista de objetos de basura, mas items, asi aparecen otros items
        // basura.aplicarMejora(null)
    }
}

object mayorValor{
    method image() = "valorIncrease.png"
    const property precio = 170
    const property descripcion = "Aumenta el valor de la basura al venderla en un 25%"
    method ventaja(_){
        negocioMejoras.bonus(1.25)
    }
}

object masVida{
    method image() = "valorIncrease.png"
    const property precio = 170
    const property descripcion = "Aumenta el valor de la basura al venderla en un 25%"
    method ventaje(persona){
        //TODO
    }
}

object masDanio{
    method image() = "valorIncrease.png"
    const property precio = 170
    const property descripcion = "Aumenta el valor de la basura al venderla en un 25%"
    method ventaje(persona){
        //TODO
    }
}


// ideas posibles de mejoras:
// escudo -> proteger de basura que puede daniar
// iman -> aumenta el radio de recoleccion ( 3 niveles: 1ro agrega un espacio en der e izq, 2do agrega arriba y abajo, 3ro aumenta de todos los lados y en diagonal )
// +velocidad
// desaparecer el timer de desaparicion de basura
// hacer aparecer x cantidad de basura en el momento