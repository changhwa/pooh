# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $("span[name=entry_btn]").click ->
    projectId = $(this).data("projectId")

    $("#user_list").html ""
    $("#entry_list").html ""
    $("#current_project_id").val(projectId)

    $.ajax
      type: "get"
      url: "/users/list"
      data: {project_id: projectId}
      dataType: "json"
      success: (data) ->
        $.each data, (index, user) ->
          template = '<option value="'+user.id+'">'+user.name+'('+user.email+')</option>'
          $("#user_list").append template
    $.ajax
      type: "get"
      url: "/projects/entry/list"
      data: {project_id: projectId}
      dataType: "json"
      success: (data) ->
        $.each data, (index, user) ->
          template = '<option value="'+user.id+'">'+user.name+'('+user.email+')</option>'
          $("#entry_list").append template

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

  $("#entry_save_btn").click ->
    options = $("#entry_list option")
    user_ids = new Array
    $.each options, (index, opt) ->
      user_ids.push $(this).val()
    $.ajax
      type: "post"
      url: "/projects/entry/join"
      data: {user_ids : user_ids,project_id : $("#current_project_id").val()}
      dataType: "json"
      success: (data) ->
        console.log data





