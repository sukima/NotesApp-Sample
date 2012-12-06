NoteModel = require("NoteModel")

NotesApp =
  init: ->
    NoteModel.loadAll()

module.exports = NotesApp
