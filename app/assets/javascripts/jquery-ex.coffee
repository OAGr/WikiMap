
$ = jQuery

# Adds plugin object to jQuery
$.fn.extend
  findSpan: ->	#Find Span name of corresponding parent object, in order to tell what row a card is in
    a = this.parent()
    if (a.hasClass("span9")) then spanClass = "span6"
    else if (a.hasClass("span6")) then spanClass = "span3"
    else if (a.hasClass("span3")) then spanClass = "span0"
    else if (a.hasClass("span0")) then spanClass = "newline"
    spanClass
  moveLeft: (ID) ->  #Refreshes the page to be one row to the left
    a = "/cards/#{ID}"
    window.location = a
  complete: -> 
    $("form").submit();
  atEnd: ->   #Uses findSpan to check of card is at right of page
    if this.findSpan() == "span0" then true
    else false
  initializeForm: ->	#Initializes the form to set it up
    $("#new_card .description").hide()
    $(".actions").hide()
    $("input:text:first").select()
    $("input:text:first").keydown (e) ->
      if (e.keyCode == 13)
        e.preventDefault(e)
        $("form .description").show()
        $("form .description textarea").select()
      else if (e.keyCode == 27)
        $("#new_card").remove()
        $().selectState()
    $("form .description").keydown (e) ->
      if (e.keyCode == 13)
        e.preventDefault(e)
        $("form").submit()
      else if (e.keyCode == 27)
        $("#new_card").remove()
        $().selectState()
