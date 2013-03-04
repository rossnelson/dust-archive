<%- flash.each do |name, msg| %>
  Dust.notice = $('<div class="flash_<%= name %>"></div>')
  Dust.notice.html('<%= escape_javascript(flash.discard(name.to_sym)) %>')

  $('#header-wrap').after(Dust.notice[0])
  $(Dust.notice[0]).delay(2000).fadeOut ()->
    $(Dust.notice).remove()
<%- end %>


