jQuery.ajaxSetup({ 
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
})

$(document).ready(function() {
$('body').append('<div class="hidden_content" style="display:none;"><div id="dialog-confirm" title="Confirm Deletion"><p>This will be permanently deleted. Are you sure?</p></div></div> ');
//Sub Menu/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   // side menu: show submenu
   $('#nav ul li').hover(function()
           {
               $(this).addClass('hover');
           },
           function()
           {
               $(this).removeClass('hover');
           });
  
  $( "#dialog-confirm" ).dialog({
       autoOpen: false,
       resizable: false,
       modal: true     
   });
   
   //Fancy Box Single Image/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
$("a#single_image").fancybox();

   //Fancy Box Single Inline content/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
     $("a#inline").fancybox({
       'transitionIn'  : 'elastic',
       'transitionOut' : 'elastic',
       'speedIn'   : 400, 
       'speedOut'    : 200,
       'hideOnContentClick': false
     });

   //Fancy Box Single Gallery/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
     $("a.group").fancybox({
       'transitionIn'  : 'elastic',
       'transitionOut' : 'elastic',
       'speedIn'   : 600, 
       'speedOut'    : 200, 
       'overlayShow' : true,
       'hideOnContentClick': true,
       'centerOnScroll': true,
       'titlePosition'     : 'over',
       'titleFormat'       : function(title, currentArray, currentIndex, currentOpts) {
           return '<span id="fancybox-title-over">' +  title + '</span>';
       }
     });
  
//Fade In and Hide Flash Messages/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  $("#flash_notice,#flash_error,#status").fadeIn().delay(2000).slideUp('slow');

$(function(){
$(".tip").tipTip({defaultPosition: "top", delay:600, fadeOut: 10, edgeOffset: 8});
});

$('.slides').cycle({timeout: 9000, pause: true, sync:true});

$('input[placeholder], textarea[placeholder]').placeholder();


//optional form fields in real estate sales order
$('.optional-fields').hide();
$('.expand-closing').bind('click', function() {
  $('.optional-fields').toggle();
});


var allPanels = $('.client-area-form > *').not('h4', 'script').hide();

  $('.client-area-form h4').click(function() {
    //$(this).addClass('active-tab');
    allPanels.slideUp();
    $(this).parent().children().next().slideDown();
    return false;
  });

});
