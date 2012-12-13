$  = jQuery
$h = Handlebars

class View
  ## TODO: Make this support more than one template per view to handle many
  ## elements.
  template: "Missing Template"
  constructor: (element) ->
    @element = $(element)
    @renderer = $h.compile(@template)
  render: (context = @) ->
    # context = @data or @ unless context?
    @element.html @renderer(context)

module.exports = View
