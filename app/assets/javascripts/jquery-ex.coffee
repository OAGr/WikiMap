
$ = jQuery

# Adds plugin object to jQuery
$.fn.extend
  findSpan: ->	#Find Span name of corresponding parent object, in order to tell what row a card is in
    a = this.parent()
    if (a.hasClass("span12")) then spanClass = "span8"
    else if (a.hasClass("span8")) then spanClass = "span4"
    else if (a.hasClass("span4")) then spanClass = "span0"
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
    $("input:text:first").keypress (e) ->
      if (e.keyCode == 13)
        e.preventDefault(e);
        $("#new_card .description").show()
        $("form .description textarea").select()
    $("#new_card .description").keypress (e) ->
      if (e.keyCode == 13)
        e.preventDefault(e);
        $("form").submit();