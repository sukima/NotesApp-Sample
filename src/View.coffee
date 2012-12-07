$  = jQuery
$m = Mustache

class View
  template: "Missing Template"
  constructor: (@element) ->
    @element = $(@element)
  render: (context = @) ->
    result = $m.render(@template, context)
    @element.html(result)
    result

module.exports = View
