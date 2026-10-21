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
        /* TODO
        CAMBIAR ESTO */
    {
        game.say(protagonista, 'GANE')
        game.schedule(10000,{pantallaVictoria.aplicarFondo()})
    }

    method reiniciar(){
        if(game.boardGround() != pantallaJuego.image())
        // Por ahora solo se ejecuta cuando el fondo no es fondo3.jpg
        {
            gestorFondo.actualizarFondo(pantallaJuego)
            self.resetJugador(protagonista)
            self.resetOtros()
            movimiento.estadoInicial()
            planificador.estadoInicial()
            self.visualizarObjetos()
            self.iniciarEventos()
        }
        
    }

    method visualizarObjetos(){
        self.mostrarObjetoSi(jugador)
        self.mostrarObjetoSi(salud)
        self.mostrarObjetoSi(cartelCash)
        self.mostrarObjetoSi(cartelInv)
        self.mostrarObjetoSi(contadorJefe)
        planificador.despausarBasura()
        vendedor.estadoInicial()
    }

    method resetJugador(personaje){
        personaje.vidas(3)
        personaje.items_recolectados().clear()
        personaje.dinero(0)
        personaje.capacidadInventario(4)
        personaje.estaVivo(true)
        personaje.recibeDanio(false)
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

    method mostrarObjetoSi(objeto){
        if(not game.hasVisual(objeto)){
            game.addVisual(objeto)
        }
    }



}