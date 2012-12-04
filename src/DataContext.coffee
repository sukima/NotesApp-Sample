NoteModel = require "NoteModel"

class DataContext
  constructor: ->
    @notes_list = []
  getNotesList: -> @notes_list
  createBlankNote: -> new NoteModel title:"", narrative:""

module.exports = DataContext
