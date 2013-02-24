Dust.sortables = {

  options : 
    disableNesting: "no-nest"
    forcePlaceholderSize: true
    handle: ".handle"
    listType: "ul"
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
    list = Dust.sortables.buildData()
    url = $('.order').data('url')

    $.post url, list

  buildData: ()->
    return {
      class_name: Dust.sortables.className()
      list: Dust.sortables.list()
    }

  className: ()->
    $('.order').data('class')

  list: ()->
    _.map($('.index-item'), (item, index)->
      return {
        id: $(item).data('id')
        position: index
      }
    )

}
