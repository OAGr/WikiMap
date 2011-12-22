# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

Card = 
  seleted: 1
  findUnit: (touchDiv) ->
    cardunit = $(touchDiv).parent().parent()

  highlight: (card) ->
    Card.selected = card
    $('.highlight .links').hide()
    $('.highlight').removeClass("highlight")
    $(Card.selected).addClass("highlight")
    $('.highlight .links').show()
    $('.highlight').selectState()
  highlightFirst: ->
      FirstCard = $('.span4:first')
      Card.highlight(FirstCard)
	
  active: ->
    return $('.highlight .links').hasClass("active")
  father: (card = $('.highlight')) ->
    $(card).parent().parent().siblings()
  child: (card = $('.highlight')) ->
    $(card).siblings().children(":first").children('.single')
  bottomSibling: (card = $('.highlight')) ->
    $(card).parent().next().children(":first")
  topSibling: (card = $('.highlight')) ->
    $(card).parent().prev().children(":first")
  topCousin: (card = $('.highlight')) ->
    father = Card.father($(card))
    uncle = Card.topSibling($(father))
    cousin = Card.child($(uncle))
  bottomCousin: (card = $('.highlight')) ->
    father = Card.father($(card))
    uncle = Card.bottomSibling($(father))
    cousin = Card.child($(uncle))

  parentSelect: ->
    father = Card.father()
    if Card.active() and (father.size() != 0) then Card.highlight(father)
  childSelect: ->
    child = Card.child() 
    if Card.active() and (child.size() != 0) then Card.highlight(child)
  siblingNextSelect: ->
    bottomSibling = Card.bottomSibling()
    bottomCousin = Card.bottomCousin()
    if Card.active() 
      if (bottomSibling.size() != 0) then Card.highlight(bottomSibling)
      else if (bottomCousin.size() != 0) then Card.highlight(bottomCousin)
  siblingPrevSelect: ->
    topSibling = Card.topSibling()
    topCousin = Card.topCousin()
    if Card.active() 
      if (topSibling.size() != 0) then Card.highlight(topSibling)
      else if (topCousin.size() != 0) then Card.highlight(topCousin)

jQuery ->
  $('.links').hide()
  $('.header').live "click", (e) ->
    card = Card.findUnit(@)
    Card.highlight(card)
  Card.highlightFirst()

  $(document).keydown (e) ->
    if (e.keyCode == 78) then $('.highlight .active .new').click()
    if (e.keyCode == 68) then $('.highlight .active .delete').click()
    if (e.keyCode == 69) then $('.highlight .active .edit').click()
    if (e.keyCode == 79) then $('.highlight .active .open').click()
    if (e.keyCode == 74) or (e.keyCode == 37) then $().left()
    if (e.keyCode == 76) or (e.keyCode == 39) then $().right()
    if (e.keyCode == 73) or (e.keyCode == 38) then $().up()
    if (e.keyCode == 75) or (e.keyCode == 40) then $().down()
jQuery.fn.extend
  editingState: ->
    $('.highlight .links').removeClass("active")
  selectState: ->
    $('.highlight .links').addClass("active")
  left: -> 
    Card.parentSelect()
  right: ->
    Card.childSelect()
  down: ->
    Card.siblingNextSelect()
  up: ->
    Card.siblingPrevSelect()
