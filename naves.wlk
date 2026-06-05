class Nave {
  var velocidad
  var direccion

  method direccion() = direccion
  method escaparDelSol(){ direccion = -10 }
  method ponerseParaleloAlSol() { direccion = 0 }
  method irHaciaElSol() {direccion = 10}
  method acercarseUnPocoAlSol() {direccion = (direccion + 1).min(10)}
  method alejarseUnPocoDelSol() {direccion = (direccion - 1).max(-10)}

  method acelerar(valor) { velocidad = (velocidad + valor).min(100000) }
  method desacelerar(valor) { velocidad = (velocidad - valor).max(0) }
}

class NaveBaliza inherits Nave {
  var color

  method color()= color
  method cambiarColorDeBaliza(colorNuevo) {color = colorNuevo}  
}
class NavePasajeros inherits Nave {
  var pasajeros
  var comida
  var bebida

  method cargarComida(cantidad){comida += cantidad}
  method consumirComida(cantidad){comida -= cantidad}
  method cargarBebida(cantidad){bebida += cantidad}
  method consumirBebida(cantidad){bebida -= cantidad}
}
class NaveConbate inherits Nave {
  var visible
  var misiles
  const mensajes = []

  method ponerseVisible(){visible = true}
  method ponerseInvisible(){visible = false}
  method estaInvisible(){}

  method desplegarMisiles(){misiles = true}
  method replegarMisiles(){misiles = false}
  method misilesDesplegados(){}

  //emitir mensajes, cada mensaje se representa como un String, p.ej. "Llegando a Saturno".
  method emitirMensaje(mensaje) {mensajes.add(mensaje)}
  method mensajesEmitidos() {mensajes.size()}
  method primerMensajeEmitido() { mensajes.first()}
  method ultimoMensajeEmitido() {mensajes.last()}

  method esEscueta(){mensajes.any({m => m.length() > 30 })}
  method emitioMensaje(mensaje) {  }
}
  