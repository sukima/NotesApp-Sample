View = require("View")
Note = require("NoteModel")
$ = jQuery

class IndexView extends View
  render: ->
    super
    @element.children("ul").listview()
  template: """
            <ul class="notes-index-list" data-role="listview">
              {{#notes}}
                <li>
                  <a href="#note-narrative-page?noteId={{id}}">
                    <div>{{title}}</div>
                    <div class="list-item-narrative">{{briefNarrative}}</div>
                  </a>
                </li>
              {{/notes}}
            </ul>
            {{^notes}}<div class="no-notes">Create a new note by clicking the <a href="#note-editor-page">new</a> button.</div>{{/notes}}
            """

module.exports = IndexView
