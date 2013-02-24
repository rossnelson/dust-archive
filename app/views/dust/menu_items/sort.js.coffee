Dust.notice = $('<div class="flash_notice"></div>')
Dust.notice.html('<%= escape_javascript(flash.discard(:notice)) %>')

$('#header-wrap').after(Dust.notice[0])
$(Dust.notice[0]).delay(2000).fadeOut ()->
  $(Dust.notice).remove()

