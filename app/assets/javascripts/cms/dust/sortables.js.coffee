Dust.sortables = {

  options : 
    disableNesting: "no-nest"
    forcePlaceholderSize: true
    handle: ".handle"
    items: "li"
    maxLevels: 2
    opacity: .6
    placeholder: "placeholder"
    tabSize: 15
    tolerance: "pointer"
    revert: 250
    toleranceElement: "> div"

  init : ()->
    $("ul#tree").nestedSortable Dust.sortables.options

    $('.order').bind 'click', ()->
      Dust.sortables.saveItems()
      false

  saveItems : (list, url)->
    list = $('#tree').serializelist()
    url = $('#tree').data('url')
    $.post url, list

}
