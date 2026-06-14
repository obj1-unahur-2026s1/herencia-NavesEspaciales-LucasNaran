class Nave {
  var velocidad
  var direccion
  var combustible

  method combustible() = combustible
  method cargarCombustible(unaCantidad){combustible += unaCantidad}
  method descargarCombustible(unaCantidad){combustible = 0.max(combustible - unaCantidad)}

  method velocidad() = velocidad
  method direccion() = direccion
  method escaparDelSol(){ direccion = -10 }
  method ponerseParaleloAlSol() { direccion = 0 }
  method irHaciaElSol() {direccion = 10}
  method acercarseUnPocoAlSol() {direccion = (direccion + 1).min(10)}
  method alejarseUnPocoDelSol() {direccion = (direccion - 1).max(-10)}

  method acelerar(valor) { velocidad = (velocidad + valor).min(100000) }
  method desacelerar(valor) { velocidad = (velocidad - valor).max(0) }

  method prepararViaje(){
    self.cargarCombustible(30000)
    self.acelerar(5000)
  }

  method estaTranquila() = combustible > 4000 and velocidad <= 12000 and self.condicionAdicional()

  method condicionAdicional()

  method recibirAmenaza(){
    self.escapar()
    self.avisar()
  }
  method escapar()
  method avisar()

  method estaDeRelajo() = self.estaTranquila() and self.tienePocaActividad()
  method tienePocaActividad()
}

class NaveBaliza inherits Nave {
  var color
  var noCambioDeColor = true 

  method color()= color
  method cambiarColorDeBaliza(colorNuevo) {
    color = colorNuevo
    noCambioDeColor = false
    }  

  override method prepararViaje(){
    super()
    self.cambiarColorDeBaliza("verde")
    self. ponerseParaleloAlSol()
  }

  override method condicionAdicional() = not (color == "rojo")

  override method escapar() { self.irHaciaElSol()}
  override method avisar() { self.cambiarColorDeBaliza("rojo") }

  override method tienePocaActividad() = noCambioDeColor
}
class NavePasajeros inherits Nave {
  const pasajeros
  var comida
  var bebida
  var racionesConsumidasDeComida = 0

  method comida()= comida
  method bebida() = bebida

  method cargarComida(cantidad){comida += cantidad}
  method consumirComida(cantidad){
    comida = (comida - cantidad).max(0)
    racionesConsumidasDeComida += cantidad 
    }
  method cargarBebida(cantidad){bebida += cantidad}
  method consumirBebida(cantidad){ bebida = (bebida - cantidad).max(0) }

  override method prepararViaje(){
    super()
    self.cargarComida(4 * pasajeros)
    self.cargarBebida(6 * pasajeros)
    self.acercarseUnPocoAlSol()
  }

  override method condicionAdicional() = true

  override method escapar() { self.acelerar(velocidad)}
  override method avisar() { 
    self.consumirComida(pasajeros)
    self.consumirBebida(pasajeros * 2)
  }

  override method tienePocaActividad() = racionesConsumidasDeComida < 50
}
class NaveCombate inherits Nave {
  var visible
  var misiles
  const mensajes = []

  method ponerseVisible(){visible = true}
  method ponerseInvisible(){visible = false}
  method estaInvisible() = visible

  method desplegarMisiles(){misiles = true}
  method replegarMisiles(){misiles = false}
  method misilesDesplegados()= misiles

  //emitir mensajes, cada mensaje se representa como un String, p.ej. "Llegando a Saturno".
  method emitirMensaje(mensaje) {mensajes.add(mensaje)}
  method mensajesEmitidos() = mensajes
  method cuantosMensajesEmitidos() = mensajes.size()
  method primerMensajeEmitido() = mensajes.first()
  method ultimoMensajeEmitido() = mensajes.last()

  method esEscueta() = not mensajes.any({m => m.length() > 30 })
  method emitioMensaje(mensaje) = mensajes.contains(mensaje)

  override method prepararViaje(){
    super()
    self.ponerseVisible()
    self.replegarMisiles()
    self.acelerar(15000)
    self.emitirMensaje("Saliendo en misión")
  }

  override method condicionAdicional() = not misiles

  override method escapar() {
    self.acercarseUnPocoAlSol()
    self.acercarseUnPocoAlSol()
  }
  override method avisar() {self.emitirMensaje("Amenaza recibida")}

  override method tienePocaActividad() = true
}
class NaveHospital inherits NavePasajeros{
  var quirofanosPreparados = false
  method prepararQuirofanos() {quirofanosPreparados = true}
  method cerrarQuirofanos() {quirofanosPreparados = false}

  override method condicionAdicional() = not quirofanosPreparados

  override method recibirAmenaza(){
    super() 
    self.prepararQuirofanos()
  }
}
class NaveCombateSigilosa inherits NaveCombate{
  override method condicionAdicional() {
    return super() and  visible
  }
  override method escapar(){
    super()
    self.desplegarMisiles()
    self.ponerseInvisible()
  }
}
