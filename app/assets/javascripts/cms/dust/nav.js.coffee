Dust.nav = {

  init : ()->
    $('#nav .section').bind 'click', ()->
      $('#nav, .main-wrap').toggleClass('nav-open', 100)

}

