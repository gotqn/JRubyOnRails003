# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
  $("#assignment-tabs").tabs
    show:
      effect: "fadeIn"
      duration: 500

    hide:
      effect: "fadeOut"
      duration: 500

  $("select.prompt").change ->
    if $(this).val() is ""
      $(this).addClass "prompt_option"
    else
      $(this).removeClass "prompt_option"

  $("select.prompt").mousedown ->
    $(this).removeClass "prompt_option"

  $("select.prompt").change()

  $("#assignments-accordion").accordion
    collapsible: true
    active: false
    icons:
      header: "ui-icon-plus"
      activeHeader: "ui-icon-minus"

  $('#assignments-accordion .user-tooltip').tooltip
    track: true
    tooltipClass: 'user-tooltip-default'

