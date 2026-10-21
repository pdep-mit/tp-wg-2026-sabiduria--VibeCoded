# Explicaciones teóricas

#1. Objetos  
Utilizamos objetos para representar los elementos principales del juego, cada uno con sus propios atributos y comportamientos: *jugador*, *jefe*, *vendedor*. Algunos de sus atributos son, vidas, ataques, dinero, etc. El vendedor se encarga de comprar la basura del personaje y vender las mejoras. Además activa al jefe, al colisionar al jugador con este cuando termina el timer de aparición del jefe.
También utilizamos objetos para administrar el funcionamiento del juego, como *movimiento*, *generador*, *planificador*, *negocioMejoras*.
Otros objetos se encargan de dar información visual al jugador: como *cartelInv*, *cartelCash*, *contadorJefe*, *salud*.

#2. Clases  
Se usó clases para crear varios elementos manteniendo sus características. Por ejemplo, la clase Basura, para definir las distintas "basuras" con distintos comportamientos. A su vez, estas "basuras" también son Clases, debido a que se necesitó definir una lista de estas para planificar su generación a través del mapa.  Se usó la clase Proyectil para representar los distintos proyectiles que lance el jugador; Puesto para representar cada puesto de la tienda; Casilla y Tentaculo para modelar los ataques y sus avisos visuales.

#3. Herencia  
Se aplica herencia para los distintos tipos de basura, los cuales son *Botella*, *Caja*, *Papel*, *BotellaCara* y *CajaValiosa* heredan de *Basura*
También se utilizó herencia en las mejoras: *masInv*, *masBasura*, *mayorValor*, *masVida* y *masDanio* heredan de *Ventaja*
La herencia se utilizó para evitar duplicar código y poder incorporar nuevos tipos de basura o de mejoras.

#4. Polimorfismo  
Se aplica polimorfismo al definir un método de alColisionarCon(jugador) que permite modelar todas las colisiones que tenga el jugador con los objetos visuales.
En las mejoras, el método ventaja(persona) cada una responde a un efecto distinto para el jugador. Cada "basura" también responde lo correspondiente a su clase, como valor(), image() y espacio(); además del method esRecoletadoPor() que evita duplicar código para cada tipo de "basura". 

#5. Bloques  
Se utilizaron bloques para poder modelar las acciones y eventos del juego. Por ejemplo, en jugador se usó bloques para modelar los controles del juego, también se utilizó game.schedule para modelar eventos temporizados, por ejemplo para controlar el movimiento de los proyectiles, establecer el daño del jugador y programar la aparición de basura.
Se utilizaron bloques en operaciones como forEach, map, sum y any. Por ejemplo, en *ataqueRecto* se utiliza forEach para poder mostrar todas las casillas donde aparecerá el ataque; el any verifica si el jugador se encuentra en alguna de ellas.

#6.Colecciones  
Se utilizaron colecciones para representar los conjuntos de elementos. Por ejemplo, jugador.items_recolectados guarda la basura que recolecte el jugador, a su vez que se elimina al lanzarla o venderla. 
planificador.objetos: contiene los objetos que van a aparecer en el mapa, planificador.objetosProgramados: registra los objetos que van a aparecer, para que no salgan 2 veces al mismo tiempo.
vendedor.puestos y vendedor.puestosArmamento: guardan las mejoras disponibles, una para la etapa de farmeo, y la otra cuando se activa la aparición del boss.
En ataqueRecto se usa una colección temporal de Casilla para representar las filas y columnas afectadas.
# Diagramas

*Incluír al menos un diagrama para comunicar su solución*
