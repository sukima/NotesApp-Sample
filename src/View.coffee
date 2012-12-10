$  = jQuery
$h = Handlebars

class View
  template: "Missing Template"
  constructor: (element) ->
    @element = $(element)
    @renderer = $h.compile(@template)
  render: (context = @) ->
    # context = @data or @ unless context?
    @element.html @renderer(context)

module.exports = View
