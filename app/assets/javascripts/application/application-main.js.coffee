jQuery.ajaxSetup beforeSend: (xhr) ->
  xhr.setRequestHeader "Accept", "text/javascript"

$(document).ready ->
  
  #Sub Menu/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  # side menu: show submenu
  $("#nav ul li").hover (->
    $(this).addClass "hover"
  ), ->
    $(this).removeClass "hover"

  #Fancy Box Single Image/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  $("a#single_image").fancybox()
  
  #Fancy Box Single Inline content/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  $("a#inline").fancybox
    transitionIn: "elastic"
    transitionOut: "elastic"
    speedIn: 400
    speedOut: 200
    hideOnContentClick: false

  
  #Fancy Box Single Gallery/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  $("a.group").fancybox
    transitionIn: "elastic"
    transitionOut: "elastic"
    speedIn: 600
    speedOut: 200
    overlayShow: true
    hideOnContentClick: true
    centerOnScroll: true
    titlePosition: "over"
    titleFormat: (title, currentArray, currentIndex, currentOpts) ->
      "<span id=\"fancybox-title-over\">" + title + "</span>"

  
  #Fade In and Hide Flash Messages/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  $("#flash_notice,#flash_error,#status").fadeIn().delay(2000).slideUp "slow"
  $ ->
    $(".tip").tipTip
      defaultPosition: "top"
      delay: 600
      fadeOut: 10
      edgeOffset: 8


  $(".slides").cycle
    timeout: 9000
    pause: true
    sync: true

  $("input[placeholder], textarea[placeholder]").placeholder()
  
  #optional form fields in real estate sales order
  $(".optional-fields").hide()
  $(".expand-closing").bind "click", ->
    $(".optional-fields").toggle()

