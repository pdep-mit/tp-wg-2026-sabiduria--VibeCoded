import generador.*
import negocioMejoras.*
class Ventaja {
    const property image 
    const property precio
    const property descripcion
    method ventaja(persona)
}

object masInv inherits Ventaja (
    image= "inv1.gif", 
    precio = 150, 
    descripcion = "Aumenta la capacidad del inventario en 4 lugares") {
        override method ventaja(persona){
            persona.capacidadInventario( persona.capacidadInventario() + 4 )
        } 
}
object masBasura inherits Ventaja (
    image= "masCapacidad.gif", 
    precio = 160, 
    descripcion= "Se quiere mudar mas gente a esta zona, eso quiere decir que habra mas basura") {
        override method ventaja(persona){
            planificador.agregarBasura()
        }
}


object mayorValor inherits Ventaja (
    image = "valorIncrease.png",
    precio = 170,
    descripcion = "Aumenta el valor de la basura al venderla en un 25%") {
    override method ventaja(_){
        negocioMejoras.bonus(1.25)
    }
}

object masVida inherits Ventaja(
    image = "corazon1.png",
    precio = 250,
    descripcion = "Aumenta la salud del personaje"){
    override method ventaja(persona){
        persona.vidas(persona.vidas() + 1)
    }
}

object masDanio inherits Ventaja(
    image = "danio.png",
    precio = 250,
    descripcion = "Aumenta el daño del personaje"){
    override method ventaja(persona){
        // persona.danio((persona.danio() + 0.5))
        persona.danioBonus(1.5)
    }
}


// ideas posibles de mejoras:
// escudo -> proteger de basura que puede daniar
// iman -> aumenta el radio de recoleccion ( 3 niveles: 1ro agrega un espacio en der e izq, 2do agrega arriba y abajo, 3ro aumenta de todos los lados y en diagonal )
// +velocidad
// desaparecer el timer de desaparicion de basura
// hacer aparecer x cantidad de basura en el momento