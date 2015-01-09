# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
class Attendance
  constructor: () ->
    Attendance::init()
  init: () ->

  event: () ->
    createAttendanceBook: () ->
      $.ajax
        type: "post"
        url: "/projects/15/attendances/"
        dataType: "json"
        success: (data) ->
          console.log data



jQuery ->
  window.Attendance = new Attendance()
  return