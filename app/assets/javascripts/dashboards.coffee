# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $("form").each (index, element) =>
    $(element).on("ajax:success", (e, data, status, xhr) ->
#      $(element).append xhr.responseText
      if(xhr.responseText == "true")
        $(element).parent().removeClass("wrongAnswerAnimation")
        $(element).parent().addClass("correctAnswerAnimation")
        $(element).parent().next().find("input[type=text]").focus()
      else
        $(element).parent().removeClass("correctAnswerAnimation")
        $(element).parent().addClass("wrongAnswerAnimation")
    ).on "ajax:error", (e, xhr, status, error) ->
      alert('Houve um problema ao responder, tente novamente.')
  return

$(document).ready ->
  $(document).keydown (event) ->
    if event.ctrlKey
      player = document.getElementById("player");
      if (player.paused == false)
        player.pause();
      else
        player.play();
  return

$(document).ready ->
  $('#backward').on 'click', ->
    if window.HTMLAudioElement
      try
        player = document.getElementById('player')
        player.currentTime -= 15.0
      catch e
        # Fail silently but show in F12 developer tools console
        if window.console and console.error('Error:' + e)
          return
  return

$(document).ready ->
  $('#forward').on 'click', ->
    if window.HTMLAudioElement
      try
        player = document.getElementById('player')
        player.currentTime += 15.0
      catch e
        # Fail silently but show in F12 developer tools console
        if window.console and console.error('Error:' + e)
          return
  return

