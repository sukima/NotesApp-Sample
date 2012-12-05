$ = jQuery
{getRandomInt} = require "Utils"

class NoteModel
  constructor: (options = {}) ->
    @title = options.title or ""
    @narrative = options.narrative or ""
    @created_on = new Date()
    @updated_at = @created_on
    @id = "#{@created_on}#{getRandomInt(0,100)}"
    NoteModel.data_store.push @
  save: ->
    @updated_at = new Date()
    NoteModel.saveAll()
  destroy: ->
    index = NoteModel.indexes[@id]
    return unless index >= 0 and index < NoteModel.count()
    ret = NoteModel.data_store.splice index, 1
    NoteModel.saveAll()
    NoteModel.reindex()
    ret

  # Static methods
  @STORAGE_NAMESPACE: "NotesApp.Data"
  @data_store = []
  @indexes = {}

  @saveNow = (callback) => 
    $.jStorage.set @STORAGE_NAMESPACE, @data_store
    callback?()

  @saveAll: (callback) =>
    # Deffer the saving. Make it lazy so the browser can choose when is best.
    doSave = => @saveNow callback
    setTimeout doSave, 5

  @loadAll: =>
    list = $.jStorage.get @STORAGE_NAMESPACE
    @data_store = list or []
    @reindex()
    @data_store

  @count: => @data_store.length

  @reindex: =>
    @indexes = {}
    @indexes[note.id] = index for note, index in @data_store
    @indexes

module.exports = NoteModel
