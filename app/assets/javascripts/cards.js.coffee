# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

Card = 
  seleted: 1
  findUnit: (touchDiv) ->
    cardunit = $(touchDiv).parent().parent()

  highlight: (card) -> #Selects the card passed in 
    Card.selected = card
    $('.highlight .links').hide()
    $('.highlight').removeClass("highlight") #Removes other highlights
    $(Card.selected).addClass("highlight")
    $('.highlight .links').show()
    $('.highlight').selectState()

  highlightFirst: ->  #When the DOM loads, this highlights the first card
      FirstCard = $('.span4:first')
      Card.highlight(FirstCard)

  #Changes the highlighted card to be active.  
  #This means that it can receive button presses as actions to Add / Delete / Edit / Navigate
  #This is turned off for forms, when a user doesn't want "New" pressed when an "N" is entered
  active: ->      
    return $('.highlight .links').hasClass("active")

  parentSelect: ->
    father = $('.highlight').father()
    if Card.active() and (father.parentsUntil('.container').size() != 0) then Card.highlight(father)
  childSelect: ->
    child = $('.highlight').child() 
    if Card.active() and (child.size() != 0) then Card.highlight(child)
  siblingNextSelect: ->
    bottomSibling = $('.highlight').bottomSibling()
    bottomCousin = $('.highlight').bottomCousin()
    if Card.active() 
      if (bottomSibling.size() != 0) then Card.highlight(bottomSibling)
      else if (bottomCousin.size() != 0) then Card.highlight(bottomCousin)
  siblingPrevSelect: ->
    topSibling = $('.highlight').topSibling()
    topCousin = $('.highlight').topCousin()
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

  shiftRight: ->
    rowArray = $(this).parentsUntil('.container')
    row = rowArray[ rowArray.length - 2]
    ansestor = row.children[0]
    otherRows = $(row).siblings()
    $(ansestor).hide(1000)
    $(ansestor).remove()
    $(otherRows).remove()
    $('#whiteboard').html( $('.span16').html() )

    $('.span12.card-children').addClass('span16')
    $('.span12.card-children').removeClass('span12')
    $('.span8.card-children').addClass('span12')
    $('.span8.card-children').removeClass('span8')
    $('.span4.card-children').addClass('span8')
    $('.span4.card-children').removeClass('span4')
    $('.span0.card-children').addClass('span4')
    $('.span0.card-children').removeClass('sspan0')

  father: ->
    $($(@).parent().parent().siblings())
  child: ->
    $($(@).siblings().children(":first").children('.single'))
  lastChild: ->
    $($(@).siblings().children(":last").children('.single'))
  bottomSibling: ->
    $($(@).parent().next().children(":first"))
  topSibling: ->
    $($(@).parent().prev().children(":first"))
  topCousin:  ->
    $($(@).father().topSibling().lastChild())
  bottomCousin: ->
    $($(@).father().bottomSibling().child())

