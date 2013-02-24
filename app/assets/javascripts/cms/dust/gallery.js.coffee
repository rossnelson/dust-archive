Dust.gallery = {

  uploaderInit: ()->
    if window.album
      Dust.gallery.uploader = new qq.FineUploaderBasic
        button: $("#uploader")[0]
        request:
          endpoint: "/dust/gallery/photos"
          params:
            album_id: window.album.id
            authenticity_token: $('meta[name="csrf-token"]').attr('content')
        callbacks:
          onComplete: (id, fileName, responseJSON)-> 
            Dust.spinner.stop()
            #photo = new Dust.Photo(responseJSON)
            #view = new Dust.PhotoShow(model: photo)
            #view.render()
          onSubmit: (id, fileName)->
            Dust.spinner.spin($('body')[0])

  dragSortInit: ()->
    if window.album
      $('.photos').sortable()

  init: ()->
    Dust.gallery.uploaderInit()
    Dust.gallery.dragSortInit()

}
