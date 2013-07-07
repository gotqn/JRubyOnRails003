# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
  $('#security-users-roles-accordion').accordion
    collapsible: true
    active: false
    icons:
      header: 'ui-icon-plus'
      activeHeader: 'ui-icon-minus'

    heightStyle: 'content'
    beforeActivate: ->
      $('.security-users-accordion').accordion 'option','active', false

  $('.security-users-accordion').accordion
    collapsible: true
    active: false
    icons:
      header: 'ui-icon-plus'
      activeHeader: 'ui-icon-minus'

    heightStyle: 'fill'

  $('#security-users-roles-accordion .user-tooltip').tooltip
    track: true
    tooltipClass: 'user-tooltip-default'

  $(".e-clear-form").on "click", ->
    form = $(this).closest("form")
    $(form).find("input:text").val ""
    $(form).find("input:checkbox").prop "checked", false






