
$ = jQuery

# Adds plugin object to jQuery
$.fn.extend
  # Change pluginName to your plugin's name.
  findSpan: ->
    a = this.parent()
    if (a.hasClass("span12")) then spanClass = "span8"
    else if (a.hasClass("span8")) then spanClass = "span4"
    else if (a.hasClass("span4")) then spanClass = "span0"
    else if (a.hasClass("span0")) then spanClass = "newline"
    spanClass
  moveLeft: (ID) ->
    a = "/cards/#{ID}"
    window.location = a
  atEnd: ->
    if this.findSpan() == "span0" then true
    else false
  createForm: ->
	$("input:text:first").select()
	$("input:text:first").keypress = (e) ->
      if (e.keyCode == 13)
	    e.preventDefault(e);
        $("#new_card .description").show()
        $("form .description textarea").select()
	$("#new_card .description").keypress = (e) ->
      if (e.keyCode == 13)
	    e.preventDefault(e);
        $("form").submit();
