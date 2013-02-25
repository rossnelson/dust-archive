Dust.gallery = {

  uploaderInit: ()->
    if window.album
      Dust.gallery.uploader = new qq.FineUploaderBasic
        button: $("#uploader")[0]
        request:
          endpoint: "/dust/gallery/api/photos"
          params:
            album_id: window.album.id
            authenticity_token: $('meta[name="csrf-token"]').attr('content')
        callbacks:
          onComplete: (id, fileName, responseJSON)-> 
            Dust.spinner.stop()
            photo = new Dust.gallery.Photo(responseJSON)
            view = new Dust.gallery.PhotoView(model: photo)
            view.render()
          onSubmit: (id, fileName)->
            Dust.spinner.spin($('body')[0])

  init: ()->
    Dust.gallery.uploaderInit()

    if window.album
      new Dust.WorkSpace()
      Backbone.history.start()

      $('.photos').sortable()
      $( ".photos" ).disableSelection()

}
