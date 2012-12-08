$ = jQuery
NoteModel = require("NoteModel")
IndexView = require("IndexView")

page_views =
  "notes-list-page":
    class: IndexView
    selector: "#notes-list-content"

initPageViews = ->
  page.view = new page.class(page.selector) for id, page of page_views
  page_views

class NotesApp
  constructor: ->
    d = $(document)
    d.bind "pagechange", @onPageChange

  onPageChange: (event, data) ->
    pageID = data.toPage.attr('id')
    view = page_views[pageID].view
    view?.render notes: NoteModel.findAll()
    true

  @init: =>
    doneLoading = =>
      initPageViews()
      @controller = new @
    # For initializing the app this should be done synchronously
    NoteModel.loadAll doneLoading, false

module.exports = NotesApp
