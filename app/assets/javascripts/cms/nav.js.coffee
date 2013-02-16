Dust.nav = {

  init : ()->
    $('.mega-icon').bind 'click', ()->
      $('#nav, .main-wrap').toggleClass('nav-open', 100)

}

Dust.window = {

  init : ()->
    $('.item.link a').css('opacity', .125)
    $('.main-wrap').css('width', ($(window).width() - 45))

  onResize : ()->
    $(window).resize ()->
      $('.main-wrap').css('width', ($(window).width() - 45))

}

