Dust.defaults = {

  accOptions : 
    autoHeight: false,
    navigation: true,
    collapsible: true,
    active: false

  init : ()->
    $( ".accordion" ).accordion Dust.defaults.accOptions
    $(".tip").tipTip()

}
