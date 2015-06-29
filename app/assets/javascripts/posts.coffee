# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  $('#post_category_ids').select2()

  $("#anr-post-favourite").on("ajax:success", (e, data, status, xhr) ->
    #alert(data.added)
    if(data.added)
      $(this).find("span").toggleClass("glyphicon glyphicon-star-empty glyphicon glyphicon-star")
    else
      $(this).find("span").toggleClass("glyphicon glyphicon-star glyphicon glyphicon-star-empty")
    console.log(data)
  ).on "ajax:error", (e, xhr, status, error) ->
    alert('error')

