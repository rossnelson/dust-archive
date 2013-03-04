$(document).ready ->
  $('form').on 'click', '.remove_fields', (event) ->
    $(this).siblings('input[type=hidden]').val('1')
    $(this).closest('.item').hide()
    return false

  $('form').on 'click', '.add_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp('section_id', 'g')
    section = $('#placeholder-section').html()
    $('.sections').append(section.replace(regexp, time))
    $('.section-data-more').unbind 'click'
    $('.section-data-more').bind 'click', (e)->
      $(e.target).siblings('.section-additional-data').toggle()
    return false

  $('.section-data-more').bind 'click', (e)->
    $(e.target).siblings('.section-additional-data').toggle()

  
  
