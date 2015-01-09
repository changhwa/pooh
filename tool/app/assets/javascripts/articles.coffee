# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
class Article
  constructor: () ->
    Article::init()
  init: () ->

  event: () ->
    renderProjectSelectList: () ->
      $.ajax
        type: "get"
        dataType: "json"
        url: "/projects/"
        success: (data) ->
          $.each data, (index, project) ->
            source = $("#article_project_select_list").html()
            template = Handlebars.compile(source)
            html = template(project)
            $("#article_project").append(html)


jQuery ->
  window.Article = new Article()
  return