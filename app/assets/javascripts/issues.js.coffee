# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
  $(".b-date-picker").datepicker
    dateFormat: "yy-mm-dd"
    onSelect: (date) ->
      if $(this).attr("name").indexOf("gteq") > 0
        $(this).parent().next().find("input").datepicker "option", "minDate", date
      else
        $(this).parent().prev().find("input").datepicker "option", "maxDate", date

  $("#issues-accordion").accordion
    collapsible: true
    active: false
    icons:
      header: "ui-icon-plus"
      activeHeader: "ui-icon-minus"

  $(".b-search-container input:checkbox").click ->
    group = undefined
    group = "input:checkbox[data-group='" + $(this).attr("data-group") + "']"
    $(group).prop "checked", false
    $(this).prop "checked", true

  (->
    $(".b-date-picker").each ->
      $(this).datepicker "option", "dateFormat", "yy-mm-dd"  if $(this).val().length > 10

  )()