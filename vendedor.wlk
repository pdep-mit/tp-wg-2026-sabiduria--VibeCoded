import generador.*
import jefe.*
import wollok.game.*
import mejoras.*
import negocioMejoras.*

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

    const puestos = [
        new Puesto(mejora = masInv, position = game.at(6, 11)),
        new Puesto(mejora = masBasura, position = game.at(8, 11)),
        new Puesto(mejora = mayorValor, position = game.at(10, 11))
    ]
    const puestosArmamento = [
        new Puesto(mejora = masVida, position = game.at(6,11)),
        new Puesto(mejora = masDanio, position = game.at(8,11))
    ]
    method abrirNegocio() {
        game.addVisual(self)
        self.mostrarPuestos()
    }
    method mostrarPuestos() {
        puestosActivos.forEach({ puesto=> game.addVisual(puesto)})
    }

    method cerrarPuestos(){
        puestosActivos.forEach({puesto => if(game.hasVisual(puesto)) game.removeVisual(puesto)})
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
        } else if (!vendioHaceUnMomento) {
            if(etapaFarmeo) {
                game.say(self, "¡Bienvenido a mi tienda! Traeme basura o pasá por arriba de una mejora para comprarla")
            } else {
                game.say(self, "Preparate para la pelea contra el jefe")
                self.iniciarBoss()
            }
        }
    }
    var property etapaFarmeo = true
    var property prepararBoss = false
    var property puestosActivos = puestos
    method cambiarMejoras(){
        etapaFarmeo = false
        self.cerrarPuestos()
        puestosActivos = puestosArmamento
        self.mostrarPuestos()
        game.say(self, "Terminó la etapa de farmeo, equipate antes de pelear contra el jefe final")
    }

    method iniciarBoss(){
        if (!etapaFarmeo && !prepararBoss) {
            prepararBoss = true
            game.schedule(5000, {
                self.cerrarNegocio()
                planificador.despausarBasura()
                jefe.aparecer()
            })
        }
    }
}
