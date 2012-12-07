$ = jQuery
{getRandomInt} = require "Utils"

class NoteModel
  constructor: (options = {}) ->
    @title = options.title or ""
    @narrative = options.narrative or ""
    @created_on = new Date()
    @updated_at = @created_on
    @id = "#{@created_on}#{getRandomInt(0,100)}"
    @isNew = true
  save: ->
    @updated_at = new Date()
    if @isNew
      @isNew = false
      NoteModel.data_store.push @
      NoteModel.indexes[@id] = NoteModel.data_store.length - 1
    NoteModel.saveAll()
  destroy: ->
    return if @isNew
    NoteModel.destroyNote @id

  # Static methods
  @STORAGE_NAMESPACE: "NotesApp.Data"
  @data_store = []
  @indexes = {}
  @async = true
  @async_timeing = 10

  @saveAll: (callback, async = @async) =>
    # Deffer the saving. Make it lazy so the browser can choose when is best.
    doSave = =>
      $.jStorage.set @STORAGE_NAMESPACE, @data_store
      callback?(@data_store)
    if async then setTimeout(doSave, @async_timeing) else doSave()

  @clearAll: (callback, async = @async) =>
    @data_store = []
    @indexes = {}
    doClear = =>
      $.jStorage.deleteKey @STORAGE_NAMESPACE
      callback?(true)
    if async then setTimeout(doClear, @async_timeing) else doClear()
    return

  @loadAll: (callback, async = @async) =>
    doLoad = =>
      list = $.jStorage.get @STORAGE_NAMESPACE
      @data_store = list or []
      @reindex callback, async
    if async then setTimeout(doLoad, @async_timeing) else doLoad()
    return

  @count: => @data_store.length

  @reindex: (callback, async = @async)  =>
    doIndex = =>
      @indexes = {}
      @indexes[note.id] = index for note, index in @data_store
      callback?(@indexes)
    if async then setTimeout(doIndex, @async_timing) else doIndex()
    return

  @findAll: => @data_store

  @find: (id) =>
    if id.toLowerCase() is "all" then @findAll()
    else @data_store[@indexes[id]]

  @destroyNote: (id) =>
    index = @indexes[id]
    return unless index? and index >= 0 and index < @count()
    ret = @data_store.splice index, 1
    @saveAll()
    @reindex()
    ret

module.exports = NoteModel
