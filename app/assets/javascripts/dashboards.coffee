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
#        $(element).parent().addClass("list-group-item-success")
      else
        $(element).parent().removeClass("correctAnswerAnimation")
        $(element).parent().addClass("wrongAnswerAnimation")
#        $(element).parent().addClass("list-group-item-danger")
    ).on "ajax:error", (e, xhr, status, error) ->
      alert('Houve um problema ao responder, tente novamente.')
  return


