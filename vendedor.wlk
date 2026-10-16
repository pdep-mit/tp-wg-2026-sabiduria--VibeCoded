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
    var property position = game.at(3, 10)
    const property image = "vendedor.png" 

    const puestos = [
        new Puesto(mejora = masInv, position = game.at(6, 10)),
        new Puesto(mejora = masBasura, position = game.at(9, 10)),
        new Puesto(mejora = mayorValor, position = game.at(12, 10))
    ]

    method abrirNegocio() {
        game.addVisual(self)
        puestos.forEach({ puesto => game.addVisual(puesto) })
    }

    method cerrarNegocio(){
        game.removeVisual(self)
        puestos.forEach({ puesto => game.removeVisual(puesto)})
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
            game.say(self, "¡Bienvenido a mi tienda! Traeme basura o pasá por arriba de una mejora para comprarla")
        }
    }
}
