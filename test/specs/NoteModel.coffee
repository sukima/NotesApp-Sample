require = window.require

describe "NoteModel", ->
  NoteModel = require "NoteModel"

  beforeEach ->
    NoteModel.STORAGE_NAMESPACE = "NotesApp.TestData"
    NoteModel.async = false

  afterEach ->
    NoteModel.clearAll()

  it "should define a localStorage namespace", ->
    expect( NoteModel.STORAGE_NAMESPACE ).toBeDefined()

  it "should define a count", ->
    expect( NoteModel.count ).toBeDefined()

  describe "saveAll", ->
    it "should be defined", ->
      expect( NoteModel.saveAll ).toBeDefined()

  describe "loadAll", ->
    it "should be defined", ->
      expect( NoteModel.loadAll ).toBeDefined()
    it "should correctly handle an empty localStorage", ->
      NoteModel.loadAll()
      expect( NoteModel.data_store ).toBeDefined()
      expect( NoteModel.data_store.length ).toBe 0
    it "should retore data as NoteModel objects", ->
      note = new NoteModel title: "test-restore", narrative: "test"
      id = note.id
      note.save()
      NoteModel.loadAll()
      newNote = NoteModel.find id
      expect( newNote ).toBeDefined()
      expect( newNote instanceof NoteModel ).toBeTruthy()

  describe "findAll", ->
    it "should be defined", ->
      expect( NoteModel.findAll ).toBeDefined()
    it "should return an array", ->
      expect( NoteModel.findAll() instanceof Array ).toBeTruthy()

  describe "find", ->
    beforeEach ->
      @note = new NoteModel { title: "test-title" }
      @note.save()
    it "should be defined", ->
      expect( NoteModel.find ).toBeDefined()
    it "should return a note from the data_store", ->
      test_note = NoteModel.find @note.id
      expect( test_note.title ).toBe "test-title"
    it "should allow an 'all' argument"

  describe "save", ->
    beforeEach -> @note = new NoteModel
    it "should be defined", ->
      expect( @note.save ).toBeDefined()
    it "should add to master list", ->
      a = NoteModel.data_store.length
      @note.save()
      b = NoteModel.data_store.length
      expect( b - a ).toBe 1
    it "should reindex", ->
      NoteModel.indexes = {}
      @note.save()
      expect( NoteModel.indexes[@note.id] ).toBeDefined()
    it "should return true / false", ->
      expect( @note.save() ).toBeTruthy()

  describe "destroy", ->
    beforeEach -> @note = new NoteModel
    it "should be defined", ->
      expect( @note.destroy ).toBeDefined()
    it "should remove the note", ->
      @note.save()
      a = NoteModel.count()
      @note.destroy()
      expect( NoteModel.count() ).toBe (a - 1)
    it "should ignore when not saved", ->
      a = NoteModel.count()
      @note.destroy()
      expect( NoteModel.count() ).toBe (a)
    it "should reindex", ->
      @note.save()
      id = @note.id
      @note.destroy()
      expect( NoteModel.indexes[id] ).not.toBeDefined()
    it "should return true or false", ->
      @note.save()
      expect( @note.destroy() ).toBeTruthy()

  describe "constructor", ->
    it "should have sane defaults", ->
      note = new NoteModel
      expect( note.title ).toBe ""
      expect( note.narrative ).toBe ""
    it "should create model properties", ->
      note = new NoteModel
      expect( note.created_on ).toBeDefined()
      expect( note.updated_at ).toBeDefined()
      expect( note.id ).toBeDefined()
    it "should handle reconstruction", ->
      note = new NoteModel title: "reconstruction-test"
      test =
        id: note.id
        title: note.title
        narrative: note.narrative
        created_on: note.created_on
        updated_at: note.updated_at
      newNote = new NoteModel test, true
      expect( newNote.id ).toBe test.id
      expect( newNote.title ).toBe test.title
      expect( newNote.narrative ).toBe test.narrative
      expect( newNote.created_on ).toBe test.created_on
      expect( newNote.updated_at ).toBe test.updated_at
      expect( newNote.isNew ).not.toBeTruthy()
    it "throw an error with bad reconstruction", ->
      shouldThrowError = -> new NoteModel {}, true
      expect( shouldThrowError ).toThrow()

  describe "briefNarrative", ->
    beforeEach ->
      @note = new NoteModel narrative: "Lorem ipsum dolor sit amet, consectetur
        adipiscing elit. Suspendisse quam lacus, mollis ut molestie nec,
        venenatis ut ligula. Vestibulum ante ipsum primis in faucibus orci
        luctus et ultrices posuere cubilia Curae; Cras enim eros, sagittis eu
        semper sit amet, adipiscing eget massa. Cras urna neque, vulputate ac
        feugiat vitae, pretium sed nibh. Morbi et mauris magna, vitae euismod
        lacus. Pellentesque habitant morbi tristique senectus et netus et
        malesuada fames ac turpis egestas. Donec rutrum felis ligula, eu
        adipiscing diam. Aenean mattis cursus ligula et dapibus. Duis
        placerat convallis iaculis. Pellentesque habitant morbi tristique
        senectus et netus et malesuada fames ac turpis egestas. Suspendisse
        potenti. In hac habitasse platea dictumst. Nunc dignissim justo in mi
        vehicula ut vestibulum sem congue. Nam dui mauris, imperdiet vitae
        ornare a, viverra a nunc."
    it "should truncate long narative", ->
      expect( @note.briefNarrative(15).length <= 15 ).toBeTruthy()
    it "should not truncate small narrative", ->
      @note.narrative = "Lorem ipsum dolor sit amet"
      len = @note.narrative.length
      expect( @note.briefNarrative(100).length ).toBe len
    it "should allow a default", ->
      len = @note.narrative.length
      expect( @note.briefNarrative().length <= len ).toBeTruthy()
    it "should return empty string if narrative was empty", ->
      n = new NoteModel
      expect( n.briefNarrative() ).toBe ""
      
