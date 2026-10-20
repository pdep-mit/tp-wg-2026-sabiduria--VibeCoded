import movimientos.* // config
import vendedor.* // config
import hud.* // config
import personajes.* // config
import generador.*
import gestorFondo.*
import jefe.*
import negocioMejoras.*
object config{
    const protagonista = jugador
    const property tiempoDeAparicionDeBoss = 22000

    method victoria()
        /* TODO */
    {
        game.say(protagonista, 'GANE')
    }

    method reiniciar(){
        if(game.boardGround() != pantallaJuego.image()){
            gestorFondo.actualizarFondo(pantallaJuego)
            self.resetJugador(protagonista)
            self.resetOtros()
            movimiento.estadoInicial()
            planificador.estadoInicial()
            self.visualizarObjetos()
            self.iniciarEventos()
        } else {
            console.println("No se reinicia el juego porque aun no termino")
        }
        
    }

    method visualizarObjetos(){
        game.addVisual(jugador)
        game.addVisual(salud)
        game.addVisual(cartelCash)
        game.addVisual(cartelInv)
        game.addVisual(contadorJefe)
        planificador.despausarBasura()
        vendedor.estadoInicial()
    }

    method resetJugador(personaje){
        personaje.vidas(3)
        personaje.items_recolectados().clear()
        personaje.dinero(0)
        personaje.capacidadInventario(4)
    }

    method resetOtros()
    // resetea las caracteristicas de cada objeto a como estaban al comienzo del juego
    {
        cartelCash.estadoInicial()
        cartelInv.estadoInicial()
        negocioMejoras.estadoInicial()
        jefe.estadoInicial()
        contadorJefe.timer(tiempoDeAparicionDeBoss/1000)
    }

    method iniciarEventos(){
        contadorJefe.comenzarContador()
        game.schedule(tiempoDeAparicionDeBoss, {
            planificador.pausarBasura()
            vendedor.cambiarMejoras()
	    })
    }



}