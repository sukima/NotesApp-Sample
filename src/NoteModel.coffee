{getRandomInt} = require "Utils"

class NoteModel
  constructor: (options = {}) ->
    @title = options.title or ""
    @narrative = options.narrative or ""
    @created_on = new Date()
    @id = "#{@created_on}#{getRandomInt(0,100)}"

module.exports = NoteModel
