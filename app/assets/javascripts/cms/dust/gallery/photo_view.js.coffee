Dust.gallery.PhotoView = Backbone.View.extend({

  className: 'index-item photo-teaser'

  initialize: (options)->
    @model = options.model
    @model.bind('destroy', @remove, @)
    @model.bind('change', @spinnerInit, @)

  render: (template='#photo-template')->
    self = @
    template = Handlebars.compile($(template).html())
    @.$el.html template(self.model.attributes)
    @.$el.attr('data-id', @model.get('id'))
    $('.photos').append @el
    @el

  spinnerInit: ()->
    Dust.spinner.spin($('body')[0])

})
