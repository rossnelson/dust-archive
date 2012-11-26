
//-------------------------------------//
//                                     //
// USAGE                               //
//                                     //
// $(".divClass").ppg_menu({           //
//  menu_for_target: '.list-item-menu' //
// });                                 //
//                                     //
//-------------------------------------//

;(function($) {

  //----------------------------------//
  // Public Methods                   //
  //----------------------------------//

  $.fn.ppg_menu = function(options) {

    options = $.extend({}, $.ppg_menu.defaults, options);
    $.ppg_menu(this, options);

  }

  $.ppg_menu = function(element, options) {

    $(element).data(options);

    $(element).bind('click', function(e){
      ppg_toggle_menu(this);
    });

  }

  $.ppg_menu.defaults = {
    menu_for_target:  '.list-item-menu'
  }

  //----------------------------------//
  // Private Methods                  //
  //----------------------------------//

  ppg_toggle_menu = function(thing) {
    data   = $(thing).data();
    menu   = $(thing).siblings(data.menu_for_target);
    my_parent = $(thing).parent();

    $(my_parent).toggleClass('open');
    $(thing).toggleClass('open');
    $(menu[0]).toggleClass('open');
  };

})(jQuery);