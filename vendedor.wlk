import generador.*
import jefe.*
import wollok.game.*
import mejoras.*
import negocioMejoras.*
import configs.*

class Puesto {
    const property mejora
    const property position

    method image() = mejora.image()
    method text() = "$" + mejora.precio() // muestra el precio encima de la mejora
    method textColor() = "009933FF"

    // Lo llama la colision del jugador (ver juego.wpgm)
    method alColisionarCon(jugador) {
        vendedor.ofrecer(mejora, jugador, self)
    }
}

object vendedor {
    var property position = game.at(3, 11)
    const property image = "vendedor.png" 
    var property etapa = etapaFarmeo // Etapa inicial
    var puestos = etapa.puestos() //Composición para cada etapa
  
    method abrirNegocio() {
        if(!game.hasVisual(self)){
            game.addVisual(self)
        }
        self.cambiarMejoras()
    }
    method mostrarPuestos() {
        puestos.forEach({ puesto=> game.addVisual(puesto)})
    }

    method cerrarPuestos(){
        puestos.forEach({puesto => if(game.hasVisual(puesto)) game.removeVisual(puesto)})
    }
    method cerrarNegocio(){
        game.removeVisual(self)
        self.cerrarPuestos()
    }

    method tieneDineroPara(jugador, mejora) = jugador.dinero() >= mejora.precio()

    method ofrecer(mejora, jugador, puesto) {
        if (game.hasVisual(puesto)) {
            if (!self.tieneDineroPara(jugador, mejora)) {
                game.say(self, "Dinero insuficiente: te faltan $" + (mejora.precio() - jugador.dinero()))
            } else if (!jugador.items_recolectados().isEmpty()) {
                game.say(self, "Primero vendeme tu basura y despues comprás mejoras")
            } else {
                negocioMejoras.comprarMejora(jugador, mejora)
                game.removeVisual(puesto)
                game.say(self, "¡Gracias por tu compra! Te quedan $" + jugador.dinero())
            }
        }
    }

    var vendioHaceUnMomento = false

    method alColisionarCon(jugador) {
        if (!jugador.items_recolectados().isEmpty()) {
            const ganancia = negocioMejoras.valorItems(jugador)
            negocioMejoras.venderBasura(jugador)
            game.say(self, "¡Bienvenido a mi tienda! Por todo eso te puedo dar $" + ganancia)
            vendioHaceUnMomento = true
            game.schedule(1500, { vendioHaceUnMomento = false })
        } else if (!vendioHaceUnMomento) { //No vendió ni tiene basura
                etapa.noTieneBasura(jugador)
            }
        }

    method cambiarMejoras(){
        self.cerrarPuestos()
        puestos = etapa.puestos()
        self.mostrarPuestos()
    }
    
    method estadoInicial(){
        vendioHaceUnMomento = false
        //etapaPreparacion.resetear()
        self.siguienteEtapa(etapaFarmeo)
    }

    method siguienteEtapa(nuevaEtapa){
        etapa = nuevaEtapa
        etapa.iniciarEtapa()
    }
}

object etapaFarmeo{
    method puestos() = [
        new Puesto(mejora = masInv, position = game.at(6, 11)),
        new Puesto(mejora = masBasura, position = game.at(8, 11)),
        new Puesto(mejora = mayorValor, position = game.at(10, 11))
    ]
    method iniciarEtapa(){
        //partidaActual += 1
        //const idPartida = partidaActual
        
        vendedor.abrirNegocio()
        game.schedule(config.tiempoDeAparicionDeBoss(), {
            vendedor.siguienteEtapa(etapaPreparacion)}
        )
    }  

    method noTieneBasura(jugador) {
        game.say(vendedor, "Traeme basura o comprá alguna mejora")
    }
}

object etapaPreparacion{
    method puestos() = [
        new Puesto(mejora = masVida, position = game.at(6,11)),
        new Puesto(mejora = masDanio, position = game.at(8,11))
    ]

    method iniciarEtapa(){
        leHabloHaceUnMomento = false
        planificador.pausarBasura()
        vendedor.cambiarMejoras()
        game.say(vendedor, "Preparate antes de pelear contra el jefe!")
        //game.schedule(1500, {game.say(vendedor, "Si querés pelear contra el boss, habla conmigo")})
    }

    var leHabloHaceUnMomento = false
    
    // method resetear(){
    //     leHabloHaceUnMomento = false
    // }
    
    method noTieneBasura(jugador){
        if(!leHabloHaceUnMomento){
            game.schedule(2000, {leHabloHaceUnMomento = true})
            game.say(vendedor, "Equipate y volvé a hablarme cuando estés listo para pelear")
        } else {
            game.say(vendedor,"¡Ahí viene el boss!")
            vendedor.siguienteEtapa(etapaFinal)
        }
    }

}

object etapaFinal{
    method puestos() = []

    method iniciarEtapa() {
        game.schedule(1500, {
            vendedor.cerrarNegocio()
            planificador.despausarBasura()
            jefe.aparecer()
        })  
    }

    method noTieneBasura(jugador){}

}