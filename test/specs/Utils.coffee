require = window.require

describe "Utils libary", ->
  Utils = require "Utils"

  describe "getRandomInt", ->
    it "should return an integer", ->
      num = Utils.getRandomInt(0,100)
      expect( typeof num ).toBe "number"
      expect( num >= 0 ).toBeTruthy()
      expect( num <= 100 ).toBeTruthy()
