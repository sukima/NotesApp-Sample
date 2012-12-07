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
            <ul class="notes-index-list">
              {{#notes}}
                <li>{{title}}</li>
              {{/notes}}
            </ul>
            {{^notes}}<div class="no-notes">Create a new note by clicking the <strong>new</strong> button.</div>{{/notes}}
            """

module.exports = IndexView
