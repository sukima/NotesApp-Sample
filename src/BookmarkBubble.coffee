$ = jQuery

class BookmarkBubble extends google.bookmarkbubble.Bubble
  @STORAGE_NAMESPACE: "NotesAppp.bubble"
  constructor: ->
    @REL_ICON_ = "apple-touch-icon"
    super
  hasHashParameter: ->
    ($.jStorage.get(BookmarkBubble.STORAGE_NAMESPACE) is 1)
  setHashParameter: ->
    $.jStorage.set(BookmarkBubble.STORAGE_NAMESPACE, 1)
  showDelayed: ->
    thisShowIfAllowed = => @showIfAllowed()
    setTimeout(thisShowIfAllowed, 1000)

module.exports = BookmarkBubble
