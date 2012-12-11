View = require("View")
$ = jQuery
$h = Handlebars

class IndexView extends View
  constructor: ->
    super
    $h.registerHelper('formatGroupDate', IndexView.formatGroupDate)
    $h.registerHelper('newGroup', @newGroup)
  newGroup: (note, options) =>
    date_converted = IndexView.formatGroupDate(note.updated_at)
    if @last_updated_at isnt date_converted
      @last_updated_at = date_converted
      return options.fn(note)
    return ""
  @formatGroupDate: (date) ->
    d = new Date(date)
    "#{d.getMonth()+1}/#{d.getDate()}/#{d.getFullYear()}"
  render: (@notes) ->
    super @
    @element.children("ul").listview()
  template: """
            <ul class="notes-index-list" data-role="listview">
              {{#notes}}
                {{#newGroup .}}
                <li data-role="list-divider">{{formatGroupDate updated_at}}</li>
                {{/newGroup}}
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
