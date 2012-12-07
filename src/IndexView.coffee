View = require("View")

class IndexView extends View
  render: ->
    super()
    @element.listview()
  template: """
            <ul>
              {{#notes}}
              <li>{{note.title}}</li>
              {{/notes}}
            </ul>
            """

module.exports = IndexView
