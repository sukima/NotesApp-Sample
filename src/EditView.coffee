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
