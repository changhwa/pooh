# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $("#project_create_view_btn").click ->
    $.ajax
      type: "get"
      url: "/projects/new"
      dataType: "html"
      success: (data) ->
        $("#main-content").html(data)
        Project.event().renderProjectCreateView()
