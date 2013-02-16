window.Dust = {}

Dust.init = ()->
  Dust.window.init()
  Dust.window.onResize()
  Dust.nav.init()

$(document).ready ()->
  Dust.init()

