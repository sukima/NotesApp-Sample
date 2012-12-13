# This program is free software. It comes without any warranty, to
# the extent permitted by applicable law. You can redistribute it
# and/or modify it under the terms of the Do What You Want To Public
# License, Version 3, as published by Devin Weaver. See
# http://tritarget.org/wywtpl/COPYING for more details.
$ = jQuery
View = require("View")

# This class does not use handlebars as it only changes form values.
class EditView extends View
  render: (note) ->
    created_on = new Date(note.created_on)
    updated_at = new Date(note.updated_at)
    $("#note-id").val(note.id)
    $("#note-title-editor").val(note.title)
    $("#note-narrative-editor").val(note.narrative)
    $("#note-created-on").text(created_on.toString())
    $("#note-updated-at").text(updated_at.toString())

module.exports = EditView
