# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

Card = 
  seleted: 1
  highlightID: ""

  findUnit: (touchDiv) ->
    cardunit = $(touchDiv).parent().parent()

  highlight: (card) -> #Selects the card passed in 
    Card.selected = card
    $('.highlight').removeClass("highlight") #Removes other highlights
    Card.selectedHighlight()
    Card.showDescriptions()

  selectedHighlight: ->
    $(Card.selected).addClass("highlight")
    $('.highlight').selectState()

  showDescriptions: ->
    #children = $($('.highlight').siblings().children().children('.single')).children().children('.description')
    allDescriptions = $('.description')    
    BranchDescriptions = $('.highlight').parent().find('.description').hide(200)
    #BranchDescriptions = $('.highlight').parentsUntil('.container').find('.description')
    allDescriptions.not(BranchDescriptions).show(200)
    #BranchDescriptions.show(100)

  storeHighlight: ->
    Card.highlightID = "#" + $('.highlight').parent()[0].id + " .single"

  restoreHighlight: ->
    Card.highlight($(Card.highlightID)[0])
 
  highlightFirst: ->  #When the DOM loads, this highlights the first card
      FirstCard = $('.Whiteboard .span4:first')
      Card.highlight(FirstCard)

  #Changes the highlighted card to be active.  
  #This means that it can receive button presses as actions to Add / Delete / Edit / Navigate
  #This is turned off for forms, when a user doesn't want "New" pressed when an "N" is entered
  active: ->      
    $('.highlight').hasClass("active")

  parentSelect: ->
    father = $('.highlight').father()
    if Card.active() and (father.parentsUntil('.container').size() != 0) then Card.highlight(father)
    else $().shift("right")

  childSelect: ->
    child = $('.highlight').child() 
    if $('.highlight').siblings().hasClass("span0") then $().shift("left")
    else if (child.size() != 0) and Card.active() then Card.highlight(child)

  siblingSelect: ( change ) ->
    spanLink = $('.highlight').parent().parent().whichClass(['Whiteboard','span16','span12','span8','span4','span0'])
    column = $(" .#{spanLink} > .row")
    highlightParent = $('.highlight').parent()[0]
    newIndex = column.index(highlightParent) + change
    if (column[newIndex] != undefined)
      newCard = column[newIndex].children[0]
      Card.highlight($(newCard))

jQuery ->
  $('.links').hide()
  $('.description').hide()
  $( '.submit').hide()
  $('.header').live "click", (e) ->
    card = Card.findUnit(@)
    Card.highlight(card)
  Card.highlightFirst()

  spinner = $().createSpinner()
  $('.spinner').html(spinner.el)
  $('.spinner').hide()

  $(document).keydown (e) ->
    if Card.active()
      switch e.keyCode
        when 78 then $('.highlight .new').click()
        when 68 then $('.highlight .delete').click()
        when 69 then $('.highlight .edit').click()
        when 79 then $('.highlight .open').click()
        when 74, 37 then $().left()
        when 76, 39 then $().right()
        when 73, 38 then $().up()
        when 75, 40 then $().down()
        when 83 then $().shift("right")
        when 65 then $().shift("left")

  $(".btn.new").click ->
    $('.highlight .new').click()
  $(".btn.edit").click ->
    $('.highlight .edit').click()
  $(".btn.delete").click ->
    $('.highlight .delete').click()
  $(".btn.submit").click ->
    $("form").submit()

jQuery.fn.extend
  whichClass: (classArray) ->	
    return item for item in classArray when this.hasClass(item)
 
  editingState: ->
    $('.highlight').removeClass("active")
    $('.btn').not('.submit').hide()
    $('.btn.submit').show()

  selectState: ->
    $('.highlight').addClass("active")
    $('.btn.submit').hide()
    $('.btn').not('.submit').show()

  left: -> 
    Card.parentSelect()
  right: ->
    Card.childSelect()
  down: ->
    Card.siblingSelect(1)
  up: ->
    Card.siblingSelect(-1)

  highlight1: ->
    Card.highlight(this)

  shift: (direction = "left", callback_fxn) ->
    $('.spinner').show()
    rowArray = $('.highlight').parentsUntil('.container')
    row = rowArray[ rowArray.length - 2]
    otherRows = $(row).siblings()
    ansestor = row.children[0]
    newCard = $(ansestor).findId()
    
    switch direction
      when "right" 
        levelTag = "?level=2"
        deleteColumn = $()
      when "left"
        levelTag = ""
        deleteColumn = $(ansestor)

    id = "/cards/" + newCard + ".html" + levelTag + " .Whiteboard>.row"
    nav = "/cards/" + newCard + ".html" + levelTag + " .parent-list li"
    Card.storeHighlight()
    $(deleteColumn).hide (50)
    $(deleteColumn).remove()
    $('.parent-list').load(nav)	
    $('.Whiteboard').load id, ->
      $(otherRows).hide(100)
      Card.restoreHighlight() 
      if ($('.highlight').length == 0)
         Card.highlightFirst()
      callback_fxn() if callback_fxn and typeof(callback_fxn) is "function"
      $('.spinner').hide()
      $('.links').hide()
	  

    #$.ajax
    #  type: 'GET'
    #  dataType: 'html'
    #  url: id,
    #  success: (data, textStatus, jqXHR) ->
    #    $('#Whiteboard').append(data);
    #    alert('Load was performed.');

    
   
   #$('#Whiteboard').load id, -> 
    #$(otherRows).hide(1000)
    #$(ansestor).hide 1000, ->
    #  $('.container').load newCard
     #alert 'Load was performed.'
		#$('#whiteboard').html( $('.span16').html() )

    #$('.span12.card-children').addClass('span16')
    #$('.span12.card-children').removeClass('span12')
    #$('.span8.card-children').addClass('span12')
    #$('.span8.card-children').removeClass('span8')
    #$('.span4.card-children').addClass('span8')
    #$('.span4.card-children').removeClass('span4')
    #$('.span0.card-children').addClass('span4')
    #('.span0.card-children').removeClass('span0')

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

  createSpinner: -> 
    opts = 
      lines: 8 #// The number of lines to draw
      length: 7 #// The length of each line
      width: 4 #// The line thickness
      radius: 4 #// The radius of the inner circle
      color: '#888' #// #rgb or #rrggbb
      speed: 2 #// Rounds per second
      trail: 62 #// Afterglow percentage
      shadow: false #// Whether to render a shadow

    spinner = new Spinner(opts).spin()
    spinner
	
  findId: ->
    parent = $(this).parent()
    cardId = $(parent)[0].id
    regexp = /\d+/
    regexp.exec(cardId)[0];    
