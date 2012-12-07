View = require("View")
Note = require("NoteModel")
$ = jQuery

class IndexView extends View
  constructor: ->
    super
    @notes = Note.findAll()
  render: ->
    super
    @element.children("ul").listview()
  template: """
            <ul>
              {{#notes}}
              <li>{{note.title}}</li>
              {{/notes}}
            </ul>
            """

module.exports = IndexView
