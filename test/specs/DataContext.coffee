require = window.require

describe "DataContext", ->
  DataContext = require "DataContext"

  beforeEach ->
    @data = new DataContext()

  describe "A Public API exists and is implemented", ->
    describe "getNotesList", ->
      it "should be defined", ->
        expect( @data.getNotesList ).toBeDefined()
      it "should return an array", ->
        expect( @data.getNotesList() instanceof Array ).toBeTruthy()

    describe "createBlankNote", ->
      it "should return a blank note", ->
        note = @data.createBlankNote()
        expect( note.title.length ).toBe 0
        expect( note.narrative.length ).toBe 0
