import movimientos.* 
import vendedor.* 
import hud.* 
import personajes.* 
import generador.*
import gestorFondo.*
import jefe.*
import negocioMejoras.*
import ataquesJefe.* // AÑADIR ESTE IMPORT

object config {
    const protagonista = jugador
    const property tiempoDeAparicionDeBoss = 60000

    method victoria() {
        planificador.pausarBasura()
        ataques.detenerAtaques()
        game.allVisuals().forEach({ visual => game.removeVisual(visual) })
        pantallaVictoria.aplicarFondo()
    }

    method derrota() {
        planificador.pausarBasura()
        ataques.detenerAtaques()
        game.allVisuals().forEach({ visual => game.removeVisual(visual) })
        pantallaDerrota.aplicarFondo()
    }

    method reiniciar() {
        // Solo permite reiniciar con 'R' si se está en la pantalla de derrota o victoria
        if (game.boardGround() == pantallaDerrota.image() || 
                game.boardGround() == pantallaVictoria.image() || 
                game.boardGround() == pantallaInicial.image() ) {
            gestorFondo.actualizarFondo(pantallaJuego)
            self.resetJugador(protagonista)
            self.resetOtros()
            movimiento.estadoInicial()
            planificador.estadoInicial()
            self.visualizarObjetos()
            self.iniciarEventos()
        }
    }

    method visualizarObjetos() {
        self.mostrarObjetoSi(jugador)
        self.mostrarObjetoSi(salud)
        self.mostrarObjetoSi(cartelCash)
        self.mostrarObjetoSi(cartelInv)
        self.mostrarObjetoSi(contadorJefe)
    }

    method resetJugador(personaje) {
        personaje.vidas(3)
        personaje.items_recolectados().clear()
        personaje.dinero(0)
        personaje.capacidadInventario(4)
        personaje.estaVivo(true)
        personaje.recibeDanio(false)
    }

    method resetOtros() {
        cartelCash.estadoInicial()
        cartelInv.estadoInicial()
        negocioMejoras.estadoInicial()
        jefe.estadoInicial()
        contadorJefe.timer(tiempoDeAparicionDeBoss / 1000)
    }
    method iniciarEventos() {
        contadorJefe.comenzarContador()
        self.visualizarObjetos()
        vendedor.estadoInicial()
        planificador.despausarBasura()
    }
    
    method mostrarObjetoSi(objeto) {
        if (not game.hasVisual(objeto)) {
            game.addVisual(objeto)
        }
    }
}