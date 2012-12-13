# This program is free software. It comes without any warranty, to
# the extent permitted by applicable law. You can redistribute it
# and/or modify it under the terms of the Do What You Want To Public
# License, Version 3, as published by Devin Weaver. See
# http://tritarget.org/wywtpl/COPYING for more details.
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
