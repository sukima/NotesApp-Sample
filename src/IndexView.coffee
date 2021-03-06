# This program is free software. It comes without any warranty, to
# the extent permitted by applicable law. You can redistribute it
# and/or modify it under the terms of the Do What You Want To Public
# License, Version 3, as published by Devin Weaver. See
# http://tritarget.org/wywtpl/COPYING for more details.
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
    # "#{d.getMonth()+1}/#{d.getDate()}/#{d.getFullYear()}"
    d.toDateString()
  render: (@notes) ->
    super @
    @last_updated_at = null
    @element.children("ul").listview()
  template: """
            <ul class="notes-index-list" data-role="listview">
              {{#notes}}
                {{#newGroup .}}
                <li data-role="list-divider">{{formatGroupDate updated_at}}</li>
                {{/newGroup}}
                <li>
                  <a href="#notes-editor-page?noteId={{id}}">
                    <div>{{title}}</div>
                    <div class="list-item-narrative">{{briefNarrative}}</div>
                  </a>
                </li>
              {{/notes}}
            </ul>
            {{^notes}}<div class="no-notes">Create a new note by clicking the <a href="#notes-editor-page">new</a> button.</div>{{/notes}}
            """

module.exports = IndexView
