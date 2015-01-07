# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
class View
  constructor: () ->
    View::init()
  init: () ->
    $("#project_create_view_btn").click ->
      $.ajax
        type: "get"
        url: "/projects/new"
        dataType: "html"
        success: (data) ->
          $("#main-content").html(data)
          Project.event().renderProjectCreateView()
    View::event().renderProjectTree()
  event: () ->
    renderProjectTree: () ->
      $.ajax
        type: "get"
        url: "/projects/tree"
        dataType: "json"
        success: (data) ->
          console.log data
          source = $("#tree-project").html()
          template = Handlebars.compile(source)
          html = template(data)
          $("#menu-content").append(html)

jQuery ->
  window.View = new View()
  return