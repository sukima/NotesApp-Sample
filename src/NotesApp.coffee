$ = jQuery
NoteModel = require("NoteModel")
IndexView = require("IndexView")

page_ids =
  "notes-list-page": IndexView

class NotesApp
  constructor: ->
    d = $(document)
    d.bind "pagechange", @onPageChange

  onPageChange: (event, data) ->
    pageID = data.toPage.attr('id')
    switch pageID
      when "notes-list-page" then console.log("todo")

  @init: =>
    NoteModel.loadAll()
    @controller = new @

module.exports = NotesApp
