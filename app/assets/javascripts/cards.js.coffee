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
  parentSelect: ->
    father = $('.highlight').parent().parent().siblings()
    if Card.active() then Card.highlight(father)
  childSelect: ->
    child = $('.highlight').siblings().children(":first").children('.single')
    if Card.active() then Card.highlight(child)
  siblingNextSelect: ->
    sibling = $('.highlight').parent().next().children(":first")
    if Card.active() then Card.highlight(sibling)
  siblingPrevSelect: ->
    sibling = $('.highlight').parent().prev().children(":first")
    if Card.active() then Card.highlight(sibling)

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
