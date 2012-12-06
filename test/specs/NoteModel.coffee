require = window.require;

describe "NoteModel", ->
  Note = require "NoteModel"

  it "should define a localStorage namespace", ->
    expect( Note.STORAGE_NAMESPACE ).toBeDefined()

  it "should define data_store as an object", ->
    expect( Note.data_store ).toBeDefined()
    expect( Note.data_store instanceof Array ).toBeTruthy()

  it "should define a count", ->
    expect( Note.count ).toBeDefined()

  describe "loadAll", ->
    it "should be defined", ->
      expect( Note.loadAll ).toBeDefined()
    it "should return an array", ->
      expect( Note.loadAll() instanceof Array ).toBeTruthy()

  describe "findAll", ->
    it "should be defined", ->
      expect( Note.findAll ).toBeDefined()
    it "should return an array", ->
      expect( Note.findAll() instanceof Array ).toBeTruthy()

  describe "find", ->
    beforeEach -> @note = new Note { title: "test-title" }
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

  describe "destroy", ->
    beforeEach -> @note = new Note
    it "should be defined", ->
      expect( @note.destroy ).toBeDefined()
    it "should remove the note", ->
      a = Note.count()
      @note.destroy()
      expect( Note.count() ).toBe (a - 1)
    it "should reindex", ->
      id = @note.id
      @note.destroy()
      expect( Note.indexes[id] ).not.toBeDefined()

  describe "constructor", ->
    it "should add to master list", ->
      a = Note.data_store.length
      note = new Note
      b = Note.data_store.length
      expect( b - a ).toBe 1
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
    it "should reindex", ->
      Note.indexes = {}
      note = new Note
      expect( Note.indexes[note.id] ).toBeDefined()
