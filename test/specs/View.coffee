require = window.require

describe "View", ->
  View = require("View")

  beforeEach ->
    @view = new View()

  it "should define a render method", ->
    expect( @view.render ).toBeDefined()
