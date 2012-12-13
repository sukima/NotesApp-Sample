$ = jQuery
NoteModel = require("NoteModel")

routes =
  "#notes-list-page":
    events: "bs"
    handler: "index"
  "#notes-editor-page":
    events: "bs"
    handler: "edit"

page_views =
  index:
    class: require("IndexView")
    selector: "#notes-list-content"
  edit:
    class: Object
    selector: "#notes-editor-content"

NotesApp =
  init: ->
    #/ A callback to finish initalization. This will create the views. It is
    #/ done in a callback so that the stored data is available before a View is
    #/ constructed (just in case).
    initPageViews = ->
      page.view = new page.class(page.selector) for action, page of page_views
      page_views
    #/ Instanciate a router.
    NotesApp.router = new $.mobile.Router(routes, NotesApp)
    #/ For initializing the app this should be done synchronously
    NoteModel.loadAll initPageViews, false

  index: (eventType, matchObj, ui, page, evt) ->
    notes = $.extend [], NoteModel.findAll() # clone the array
    #/ http://jsbin.com/igijuz/10/edit
    notes.sort (a,b) ->
      if a.updated_at < b.updated_at then return 1
      else if a.updated_at is b.updated_at then return 0
      else return -1
    page_views.index.view.render(notes)

  edit: (eventType, matchObj, ui, page, evt) -> console.log("#edit")

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
