//valor es el precio de venta, espacio es cuanto ocupa en el inventario, tiempoRegeneracion es cuanto tiempo pasa antes de que se vuelva a regenerar,
//tiempoDesaparicion es cuanto tiempo está en el tablero antes de desaparecer
object botella {
	var property position = game.at(0, 0)
	method image() = "botella.png"
	method valor() = 4
	method espacio() = 1
    const property tiempoRegeneracion = 3000 //en ms
    const property tiempoDesaparicion = 7000

    method serAgarrado(jugador){ /*hace algo ♦ polimorfico ♦ (implementar) */ }
}

object caja {
	var property position = game.at(0, 0)
	method image() = "caja.png"
	method valor() = 10
	method espacio() = 2
    const property tiempoRegeneracion = 3000 //en ms
    const property tiempoDesaparicion = 7000

    method serAgarrado(jugador){ /*hace algo ♦ polimorfico ♦ (implementar) */ }
}

object papel {
	var property position = game.at(0, 0)
	method image() = "papel.png"
	method valor() = 1
	method espacio() = 1
    const property tiempoRegeneracion = 3000 //en ms
    const property tiempoDesaparicion = 7000

    method serAgarrado(jugador){ /*hace algo ♦ polimorfico ♦ (implementar) */ }
}


/*
FALTA: 
implementar lo del espacio que ocupan
Agregar el serAgarrado
Agregarle los sprites a las basuras

*/