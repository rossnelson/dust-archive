Dust.gallery.PhotosView = Backbone.View.extend({

  className: 'photos'

  initialize: (options)->
    @collecton = options.collection

  render: ()->
    @collection.each (model)->
      photoView = new Dust.gallery.PhotoView({model:model})
      photoView.render()
})
