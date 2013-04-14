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
    $("ul#tree").nestedSortable @options

    $('.order').bind 'click', ()=>
      @saveItems()
      false

  saveItems : (list, url)->
    list = @buildData()
    url = $('.order').data('url')

    $.post url, list

  buildData: ()->
    return {
      class_name: @className()
      list: @list()
    }

  className: ()->
    $('.order').data('class')

  list: ()->
    children = new Array()
    @itemList = _.map($('.index-item, .sortable-item'), (item, index)->
      data =
        id: $(item).data('id')
        position: index
        parent_id: $(item).parent().parent().data('id')
        children: new Array()
      if data.parent_id
        children.push(data)
        return false
      else
        return data
    )
    @buildChildren(children)

    _.compact(@itemList)

  buildChildren: (children)->
    _.each children, (item)=>
      parent = _.findWhere(@itemList, {id: item.parent_id})
      parent.children.push(item)

}
