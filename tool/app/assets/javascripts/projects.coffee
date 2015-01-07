# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class Project
  constructor: () ->
  event: () ->
    renderProjectCreateView: () ->
      $.ajax
        type: "get"
        url: "/users/list"
        dataType: "json"
        success: (data) ->

          $.each data, (index, user) ->
            template = '<option value="'+user.id+'">'+user.name+'('+user.email+')</option>'
            $("#user_list").append template

          $("#user_list").change ->
            seletedElement = $("#user_list option:selected")
            template = '<option value="'+seletedElement.val()+'">'+seletedElement.text()+'</option>'
            $("#entry_list").append template
            seletedElement.remove()

          $("#entry_list").change ->
            seletedElement = $("#entry_list option:selected")
            template = '<option name="user_ids" value="'+seletedElement.val()+'">'+seletedElement.text()+'</option>'
            $("#user_list").append template
            seletedElement.remove()

          $("#project_create_btn").click ->
            options = $("#entry_list option")
            user_ids = new Array
            $.each options, (index, opt) ->
              user_ids.push $(this).val()
            formData = {}
            formData.title = $("#project_title").val();
            formData.user_ids = user_ids

            $.ajax
              type: "post"
              url: "/projects"
              data: {project: formData}
              dataType: "json"
              success: (data) ->
                console.log 'ssss'
                console.log (data)

jQuery ->
  window.Project = new Project()
  return