Dust.nav = {

  init : ()->
    $('.main-wrap').data('state', 'open')

    $('#nav .section').bind 'click', ()->
      state = $('.main-wrap').data('state')
      Dust.nav[state]()

  open : ()->
    $('.main-wrap').animate {'width': ($(window).width() - 190)}, 100, (a)->
      $("#nav").toggleClass('nav-open')
      $('.main-wrap').data('state', 'close')

  close : ()->
    $('.main-wrap').animate {'width': ($(window).width() - 45)}, 100, (a)->
      $("#nav").toggleClass('nav-open')
      $('.main-wrap').data('state', 'open')

}

