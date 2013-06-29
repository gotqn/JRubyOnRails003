# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
  $('#security-users-accordion').accordion
    collapsible: true
    active: false
    icons:
      header: 'ui-icon-plus'
      activeHeader: 'ui-icon-minus'