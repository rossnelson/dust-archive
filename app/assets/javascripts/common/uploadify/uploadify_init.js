$(function() {

jQuery.ajaxSetup({ 
  'beforeSend': function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))}
})

  $('#new_account_file').uploadify({
    'uploader'       : '/uploadify/uploadify.swf',
    'script'         : '/batches',
    'cancelImg'      : '/assets/plugins/uploadify/cancel.png',
    'folder'         : '/uploads',
    'fileDataName'   : 'account_file[content]',
    'multi'          : true,
    'auto'           : false,
    //'fileExt'        : '*.jpg;*.gif;*.png',
    //'fileDesc'       : 'Image Files (.JPG, .GIF, .PNG)',
    'queueSizeLimit' : 20,
    'simUploadLimit' : 3,
    'sizeLimit'      : 100000000000,
    'removeCompleted': true,
    'hideButton'     : true,
    'wmode'          : 'transparent',
    'width'          : '133px', //even if i make these bigger, the "clickable button area" doesn't grow
    'height'         : '32px',
    'scriptData'     : window.uploadifyData,
    'onComplete'     : function(event, queueID, fileObj, response, data) { var dat = eval('(' + response + ')');$.getScript(dat.account_file);},
    'onSelectOnce'   : function(event,data) {$('#status-message').text(data.filesSelected + ' files have been added to the queue.');},
    'onAllComplete'  : function(event,data) {$('#status-message').text(data.filesUploaded + ' files uploaded, ' + data.errors + ' errors.');}
  });

  update_list = function(event, queueID, fileObj, response, data) { 
    var dat = eval('(' + response + ')');
    $.getScript(dat.photo);
  }

  $('#upload-files').click(function(event){
    event.preventDefault(); 
    $('#new_account_file').uploadifyUpload(); 
  });
});