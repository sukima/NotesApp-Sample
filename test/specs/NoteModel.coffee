require = window.require

describe "NoteModel", ->
  Note = require "NoteModel"

  beforeEach ->
    Note.STORAGE_NAMESPACE = "NotesApp.TestData"
    Note.async = false

  afterEach ->
    Note.clearAll()

  it "should define a localStorage namespace", ->
    expect( Note.STORAGE_NAMESPACE ).toBeDefined()

  it "should define a count", ->
    expect( Note.count ).toBeDefined()

  describe "loadAll", ->
    it "should be defined", ->
      expect( Note.loadAll ).toBeDefined()

  describe "findAll", ->
    it "should be defined", ->
      expect( Note.findAll ).toBeDefined()
    it "should return an array", ->
      expect( Note.findAll() instanceof Array ).toBeTruthy()

  describe "find", ->
    beforeEach ->
      @note = new Note { title: "test-title" }
      @note.save()
    it "should be defined", ->
      expect( Note.find ).toBeDefined()
    it "should return a note from the data_store", ->
      test_note = Note.find @note.id
      expect( test_note.title ).toBe "test-title"
    it "should allow an 'all' argument"

  describe "save", ->
    beforeEach -> @note = new Note
    it "should be defined", ->
      expect( @note.save ).toBeDefined()
    it "should add to master list", ->
      a = Note.data_store.length
      @note.save()
      b = Note.data_store.length
      expect( b - a ).toBe 1
    it "should reindex", ->
      Note.indexes = {}
      @note.save()
      expect( Note.indexes[@note.id] ).toBeDefined()

  describe "destroy", ->
    beforeEach -> @note = new Note
    it "should be defined", ->
      expect( @note.destroy ).toBeDefined()
    it "should remove the note", ->
      @note.save()
      a = Note.count()
      @note.destroy()
      expect( Note.count() ).toBe (a - 1)
    it "should ignore when not saved", ->
      a = Note.count()
      @note.destroy()
      expect( Note.count() ).toBe (a)
    it "should reindex", ->
      @note.save()
      id = @note.id
      @note.destroy()
      expect( Note.indexes[id] ).not.toBeDefined()

  describe "constructor", ->
    it "should have sane defaults", ->
      note = new Note
      expect( note.title ).toBe ""
      expect( note.narrative ).toBe ""
    it "should create model properties", ->
      note = new Note
      expect( note.created_on ).toBeDefined()
      expect( note.updated_at ).toBeDefined()
      expect( note.id ).toBeDefined()
    it "should handle object assignment", ->
      a = new Note { title: "a-foo" }
      b = new Note { narrative: "b-bar" }
      c = new Note { title: "c-title-foo", narrative: "c-nar-foo" }
      expect( a.title ).toBe "a-foo"
      expect( b.narrative ).toBe "b-bar"
      expect( c.title ).toBe "c-title-foo"
      expect( c.narrative ).toBe "c-nar-foo"
