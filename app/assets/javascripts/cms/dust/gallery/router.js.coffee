
Dust.WorkSpace = Backbone.Router.extend(
  routes:
    "" : "album"

  album: (album_id) ->
    if window.photos
      Dust.photos = new Dust.gallery.Photos(window.photos)
      Dust.photosView = new Dust.gallery.PhotosView(collection: Dust.photos)
      Dust.photosView.render()


)

