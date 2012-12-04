{getRandomInt} = require "Utils"

class NoteModel
  constructor: (options = { title: "", narrative: "" }) ->
    @title = options.title
    @narrative = options.narrative
    @created_on = new Date()
    @id = "#{@created_on}#{getRandomInt(0,100)}"

module.exports = NoteModel
