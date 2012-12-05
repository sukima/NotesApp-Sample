require = window.require;

describe "NoteModel", ->
  Note = require "NoteModel"

  it "should define a localStorage namespace", ->
    expect( Note.STORAGE_NAMESPACE ).toBeDefined()

  it "should define data_store as an object", ->
    expect( Note.data_store ).toBeDefined()
    expect( Note.data_store instanceof Array ).toBeTruthy()

  describe "loadAll", ->
    it "should be defined", ->
      expect( Note.loadAll ).toBeDefined()
    it "should return an array", ->
      expect( Note.loadAll() instanceof Array ).toBeTruthy()

  describe "save", ->
    beforeEach -> @note = new Note
    it "should be defined", ->
      expect( @note.save ).toBeDefined()

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
