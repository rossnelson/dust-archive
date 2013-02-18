Dust.window = {

  init : ()->
    $('.item.link a').css('opacity', .125)
    $('.main-wrap').css('width', ($(window).width() - 45))

  onResize : ()->
    $(window).resize ()->
      $('.main-wrap').css('width', ($(window).width() - 45))

}
