# This program is free software. It comes without any warranty, to
# the extent permitted by applicable law. You can redistribute it
# and/or modify it under the terms of the Do What You Want To Public
# License, Version 3, as published by Devin Weaver. See
# http://tritarget.org/wywtpl/COPYING for more details.
$ = jQuery
BookmarkBubble = require("BookmarkBubble")
Note = require("NoteModel")
IndexView = require("IndexView")
EditView = require("EditView")

routes =
  "#notes-list-page$":
    events: "s"
    handler: "index"
  "#notes-editor-page$":
    events: "s"
    handler: "newNote"
  "#notes-editor-page[?]noteId=(.+)":
    events: "s"
    handler: "editNote"

page_views =
  index:
    class: IndexView
    selector: "#notes-list-content"
  editNote:
    class: EditView
    selector: "#notes-editor-content"

# This will create the views.
# It also defines the event bindings. It is done in a callback so that
# the stored data is available before a View is constructed (just in
# case).
initPageViews = ->
  page.view = new page.class(page.selector) for action, page of page_views
  page_views

# Defines any events you want the app to handle that is not part of the
# routing.
addAppEvents = ->
  #/ Handle the save buton
  $("#save-note-button").click(NotesApp.saveNote)
  #/ Handle the delete button
  $("#delete-note-button").click(NotesApp.deleteNote)
  return

NotesApp =
  currentNote: null

  init: ->
    #/ A callback to finish initalization.
    loadAllDone = ->
      initPageViews()
      addAppEvents()
      bubble = new BookmarkBubble()
      bubble.showDelayed()
    #/ Instanciate a router.
    NotesApp.router = new $.mobile.Router(routes, NotesApp)
    #/ For initializing the app this should be done synchronously
    Note.loadAll loadAllDone, false

  index: (eventType, matchObj, ui, page, evt) ->
    notes = $.extend [], Note.findAll() # clone the array
    #/ Example from: http://jsbin.com/igijuz/10/edit
    notes.sort (a,b) ->
      if a.updated_at < b.updated_at then return 1
      else if a.updated_at is b.updated_at then return 0
      else return -1
    page_views.index.view.render(notes)

  newNote: (eventType, matchObj, ui, page, evt) ->
    NotesApp.currentNote = new Note()
    page_views.editNote.view.render(NotesApp.currentNote)

  editNote: (eventType, matchObj, ui, page, evt) ->
    NotesApp.currentNote = Note.find(matchObj[1])
    page_views.editNote.view.render(NotesApp.currentNote)

  saveNote: ->
    note = NotesApp.currentNote
    return false unless note?
    note.title = $("#note-title-editor").val()
    note.narrative = $("#note-narrative-editor").val()
    $.mobile.changePage("#notes-list-page") if note.save()

  deleteNote: ->
    note = NotesApp.currentNote
    return false unless note?
    $.mobile.changePage("#notes-list-page") if note.destroy()

module.exports = NotesApp


# Utility function used for debugging and testing
#
# Called from the console to erase and load a set of test data.
window.createTestData = ->
  count = 0
  buildNextNote = ->
    if count < 10
      n = new Note title: "Test #{count}", narrative: "Test Narrative #{count}"
      n.save()
      count++
      setTimeout buildNextNote, 100
    else
      console.log "Done."
  Note.clearAll()
  buildNextNote()
  console.log  "Processing..."
