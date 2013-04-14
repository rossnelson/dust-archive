$.ajaxSetup
  beforeSend: (xhr)->
    xhr.setRequestHeader("Accept", "text/javascript")

window.Dust = {}

Dust.init = ()->
  Dust.defaults.init()
  Dust.window.init()
  Dust.window.onResize()
  Dust.nav.init()
  Dust.sortables.init()
  Dust.gallery.init()
  Dust

$(document).ready ()->
  Dust.init()


