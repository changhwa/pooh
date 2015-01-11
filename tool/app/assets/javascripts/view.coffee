# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
class View
  constructor: () ->
    console.log "ssss"
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
    $("#tree_article_write_btn").click ->
      $.ajax
        type: "get"
        url: "/articles/new"
        dataType: "html"
        success: (data) ->
          $("#main-content").html(data)
          Article.event().renderProjectSelectList()
    View::event().renderProjectTree()
    View::event().renderDashboard()
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

          $("li[name=tree_article_list]").click ->
            $("#main-content").html("")
            source = $("#article-content-iframe").html()
            template = Handlebars.compile(source)
            html = template({id: $(this).data('articleId'), title: $(this).data('articleTitle')})
            $("#main-content").append(html)
    renderDashboard: () ->
      $.ajax
        type: "get"
        url: "/projects/15/attendances/"
        dataType: "json"
        success: (data) ->
          source = $("#attendance_book_table_template").html()
          template = Handlebars.compile(source)
          Handlebars.registerHelper 'join', (join_yn) ->
            if join_yn == 'Y'
              return new Handlebars.SafeString('<span class="label label-success">참석</span>')
            else if join_yn == 'N'
              return new Handlebars.SafeString('<span class="label label-danger">불참</span>')
            return new Handlebars.SafeString('<span class="label label-success"></span>')
          html = template(data)
          $("#main-content").append(html)

          $.ajax
            type: "get"
            url: "/projects/15/entry/list"
            dataType: "json"
            success: (data) ->
              console.log data
              source = $("#progress_chart_template").html()
              template = Handlebars.compile(source)
              html = template(data)
              $("#main-content").append(html)

          $("#attendance_book_add_btn").click ->
            $("#attendance-book").remove()
            Attendance.event().createAttendanceBook()
            View::event().renderDashboard()

          $("td[name=attendance_book_join_yn]").click ->
            that = $(this)
            attendance = {}
            attendance.entry_id = that.data('entryId')
            attendance.join_yn = that.data('joinYn')
            attendance.number = that.data('attendanceNumber')
            attendance.id= that.data('attendanceId')
            $.ajax
              type: "put"
              url: "/projects/15/attendance/"+attendance.entry_id+"/join/"+attendance.id
              data: {attendance : attendance}
              dataType: "json"
              success: (data) ->
                console.log (data)
                that.data("joinYn",data.join_yn)
                span = that.find("span")
                txt = '참석'
                if data.join_yn == 'Y'
                  span.removeClass('label-danger')
                  span.addClass('label-success')
                else
                  span.removeClass('label-success')
                  span.addClass('label-danger')
                  txt = '불참'
                that.find("span").text(txt)



jQuery ->
  window.View = new View()
  return