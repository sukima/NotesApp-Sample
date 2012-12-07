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
      a = new Note title: "a-foo"
      b = new Note narrative: "b-bar"
      c = new Note title: "c-title-foo", narrative: "c-nar-foo"
      expect( a.title ).toBe "a-foo"
      expect( b.narrative ).toBe "b-bar"
      expect( c.title ).toBe "c-title-foo"
      expect( c.narrative ).toBe "c-nar-foo"

  describe "briefNarrative", ->
    beforeEach ->
      @note = new Note narrative: "Lorem ipsum dolor sit amet, consectetur
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
      
