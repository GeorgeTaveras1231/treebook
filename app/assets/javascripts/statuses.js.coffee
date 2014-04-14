# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/



$("html").on 'focusin', ".inline-status-form textarea", ->
  
  $(".inline-status-form .form-actions").css
    display: "block"

$("html").on 'focusout', ".inline-status-form textarea", ->
  if $(this).val() is ""
    $(".inline-status-form .form-actions").css
      display: "none"