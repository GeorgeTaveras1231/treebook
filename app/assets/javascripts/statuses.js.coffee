# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$("html").on 'focusin', ".inline-status-form textarea", (e)->
  $(e.currentTarget).parents("form").children(".form-actions").css
    display: "inherit"

$("html").on 'focusout', ".inline-status-form textarea", (e)->
  if $(e.currentTarget).val() is ""
    $(e.currentTarget).parents("form").children(".form-actions").css
      display: "none"


$("html").on 'keyup', ".inline-comment-form textarea", ( e )->
  if e.shiftKey is false and e.which is 13
    e.preventDefault()
    $(e.currentTarget).parents("form").children(".form-actions").children("input").trigger("click")
  else if e.shiftKey is true and e.which is 13
    $(e.currentTarget).val( $(e.currentTarget).val() + "\n" )

$("html").on 'focusin', ".inline-comment-form textarea", (e)->
  $(e.currentTarget).parents(".status").children(".comment-list").slideDown()

$( document ).on 'focusout click', "html, .inline-comment-form textarea, .comment-list", (e)->
  #console.log e
  #if $(e.currentTarget).val() is ""
  commentList = $(".comment-list")
  e.stopPropagation()
  if e.type is "click" and $(e.currentTarget).is "html"
    commentList.slideUp()

