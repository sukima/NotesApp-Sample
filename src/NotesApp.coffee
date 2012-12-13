$ = jQuery
NoteModel = require("NoteModel")
IndexView = require("IndexView")

page_views =
  "notes-list-page":
    class: IndexView
    selector: "#notes-list-content"
    data: (url) ->
      notes = $.extend [], NoteModel.findAll() # clone the array
      ## http://jsbin.com/igijuz/10/edit
      notes.sort (a,b) ->
        if a.updated_at < b.updated_at then return 1
        else if a.updated_at is b.updated_at then return 0
        else return -1
      notes
  "notes-editor-page":
    class: Object
    selector: "#notes-editor-content"
    data: (url) ->
      console.log(url)

initPageViews = ->
  page.view = new page.class(page.selector) for id, page of page_views
  page_views

class NotesApp
  constructor: ->
    d = $(document)
    d.bind "pagechange", @onPageChange

  onPageChange: (event, data) ->
    pageID = data.toPage.attr('id')
    page_view = page_views[pageID]
    context = page_view.data(data.options.dataUrl)
    page_view.view?.render(context)
    true

  @init: =>
    ## Define a callback for the loadAll method.
    doneLoading = =>
      initPageViews()
      @controller = new @
    ## For initializing the app this should be done synchronously
    NoteModel.loadAll doneLoading, false

module.exports = NotesApp

# Utility function used for debugging and testing
#
# Called from the console to erase and load a set of test data.
window.createTestData = ->
  count = 0
  buildNextNote = ->
    if count < 10
      n = new NoteModel title: "Test #{count}", narrative: "Test Narrative #{count}"
      n.save()
      count++
      setTimeout buildNextNote, 100
    else
      console.log "Done."
  NoteModel.clearAll()
  buildNextNote()
  console.log  "Processing..."
