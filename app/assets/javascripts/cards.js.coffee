# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

Card = 
  seleted: 1
  findUnit: (touchDiv) ->
    x = touchDiv.parentElement.parentElement.parentElement.parentElement
    cardUnit = $(x).children()[0]
  highlight: (card) ->
    Card.selected = card
    $('.highlight .links').hide()
    $('.highlight').removeClass("highlight")
    $(Card.selected).addClass("highlight")
    $('.highlight .links').show()
    $('.highlight').selectState()

jQuery ->
  $('.links').hide()
  $('.title').click (e) ->
    card = Card.findUnit(@)
    Card.highlight(card)
  $(document).keypress (e) ->
    if (e.keyCode == 110) then $('.highlight .active .new').click()
    if (e.keyCode == 100) then $('.highlight .active .delete').click()
    if (e.keyCode == 101) then $('.highlight .active .edit').click()

jQuery.fn.extend
  editingState: ->
    $('.highlight .links').removeClass("active")
  selectState: ->
    $('.highlight .links').addClass("active")