# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

Card = 
  seleted: 1
  ID: ""
  IDalternate: ""

  findUnit: (touchDiv) ->
    cardunit = $(touchDiv).parent().parent()

  highlight: (card) -> #Selects the card passed in 
    Card.selected = card
    $('.highlight').removeClass("highlight") #Removes other highlights
    Card.selectedHighlight()
    Card.showDescriptions()
    $('.highlight .grab-here')[0].scrollIntoView(false)

  selectedHighlight: ->
    $(Card.selected).addClass("highlight")
    $('.highlight').selectState()

  showDescriptions: ->
    #children = $($('.highlight').siblings().children().children('.single')).children().children('.description')
    allDescriptions = $('.description')    
    #BranchDescriptions = $('.highlight').parent().find('.description').hide(200)
    #BranchDescriptions = $('.highlight').parentsUntil('.container').find('.description')
    #allDescriptions.not(BranchDescriptions).show(200)
    #BranchDescriptions.show(100)

  storeHighlight: (alternate)->
    Card.ID = "#" + $('.highlight').parent()[0].id + " .single"
    Card.IDalternate =  "#" + $(alternate).parent()[0].id + " .single"

  restoreHighlight: ->
    Card.highlight($(Card.ID)[0])
    if $('.highlight').length is 0
      Card.highlight($(Card.IDalternate))

  highlightFirst: ->  #When the DOM loads, this highlights the first card
      FirstCard = $('.Whiteboard .span3:first')
      Card.highlight(FirstCard)

  #Changes the highlighted card to be active.  
  #This means that it can receive button presses as actions to Add / Delete / Edit / Navigate
  #This is turned off for forms, when a user doesn't want "New" pressed when an "N" is entered
  active: ->      
    $('.highlight').hasClass("active")

  parentSelect: ->
    father = $('.highlight').father()
    if Card.active() and not $('.highlight').parent().parent().hasClass("Whiteboard") then Card.highlight(father)
    else $().shift("right")

  childSelect: ->
    child = $('.highlight').child() 
    if $('.highlight').siblings('.span1').not('.leftpoint').length > 0 then $().shift("left")
    else if (child.size() != 0) and Card.active() then Card.highlight(child)

  siblingSelect: ( change ) ->
    spanLink = $('.highlight').parent().parent().whichClass(['Whiteboard','span13','span10','span7','span4','span1'])
    column = $(" .#{spanLink} > .row")
    highlightParent = $('.highlight').parent()[0]
    newIndex = column.index(highlightParent) + change
    if (column[newIndex] != undefined)
      newCard = $(column[newIndex]).find('.single:first')
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

  $('.leftpoint').live "click", (e) ->
    e.preventDefault(e)
    $().shift("right")
  $('.rightpoint').live "click", (e) ->
    e.preventDefault(e)
    branchCard = $('.rightpoint').parent().siblings('.span3')
    $().shift("left", branchCard)

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

  selectRow: ( option = 'highlight') ->
    Spans = ['Whiteboard','span13','span10','span7','span4','span1']
    if option is 'highlight'
      spanLink = $('.highlight').parent().parent().whichClass(Spans)
    else 
      spanLink = Spans[option]
    $(" .#{spanLink} > .row > .single")

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

  shift: (direction = "left", card = $('.highlight'), callback_fxn) ->
    $('.spinner').show()
    $('.active').removeClass('active')
    rowArray = $(card).parentsUntil('.Whiteboard')
    row = rowArray[ rowArray.length - 1]
    otherRows = $(row).siblings()
    ansestor = row.children[1]
    newCard = $(ansestor).findId()
    
    switch direction
      when "right" 
        levelTag = "?level=2"
        $().rightAnimation()
        alternateCard = $('.highlight').child()
      when "left"
        levelTag = ""
        $().leftAnimation()
        alternateCard = $('.highlight').parent()

    id = "/cards/" + newCard + ".html" + levelTag + " .Whiteboard>.row"
    nav = "/cards/" + newCard + ".html" + levelTag + " .parent-list-inner "

    Card.storeHighlight(alternateCard)

    $('.parent-list').load(nav)	
    $('.Whiteboard').load id, ->
      $(otherRows).hide(100)
      Card.restoreHighlight() 
      if ($('.highlight').length == 0)
         Card.highlightFirst()
      callback_fxn() if callback_fxn and typeof(callback_fxn) is "function"
      $('.spinner').hide()
      $('.links').hide()
      Card.active()


#    $.ajax
#      type: 'GET'
#      dataType: 'html'
#      url: id,
#      success: (data, textStatus, jqXHR) ->
#        $('#Whiteboard').append(data);
#        alert('Load was performed.');

    
   
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


  leftAnimation: -> 
    $('.arrow a').hide(400)
    $().selectRow(0).hide 500, ->
      $(deleteColumn).remove()

  rightAnimation: ->
    $('.Whiteboard > .row').prepend("<div class='span4 right-open-hidden', style='display:none;' >  </div>")
    $('.span1.card-children').hide(300)
    $('.span4.card-children').hide(300)
    $('.span7.card-children').addClass('span4')
    $('.span7.card-children').removeClass('span7')
    $('.span10.card-children').addClass('span7')
    $('.span10.card-children').removeClass('span10')
    $('.span13.card-children').addClass('span10')
    $('.span13.card-children').removeClass('span13')
    $('.arrow').hide(300)
    $('.right-open-hidden').show(500)

  father: ->
    $($(@).parent().parent().siblings(':last'))
  child: ->
    $($(@).siblings(':last').not('span1').children(":first").children('.single'))
  lastChild: ->
    $($(@).siblings(':last').children(":last").children('.single'))
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
