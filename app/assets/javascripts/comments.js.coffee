# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

statusForm = ".inline-status-form textarea"
commentForm = ".inline-comment-form textarea"
commentList = ".comment-list"

$statusForm = $(".inline-status-form textarea")

$html = $("html")

$html.on 'focusin', statusForm, (e)->
  $current = $(e.currentTarget)
  $current.parents("form").children(".form-actions").css
    display: "inherit"

$html.on 'focusout', statusForm, (e)->
  $current = $(e.currentTarget)
  if $current.val() is ""
    $current.parents("form").children(".form-actions").css
      display: "none"
    $current.css
      height: "initial"


$html.on 'keydown', commentForm, (e)->
  $current = $(e.currentTarget)
  if e.shiftKey is false and e.which is 13 #press enter
    $current.parents("form").trigger('submit')
    $current.prop('value', '')
    $current.trigger('blur')

$html.on 'focusin', commentForm, (e)->
  $current = $(e.currentTarget)
  $current.parents("[class^='status-']").children(".comment-list").slideDown()

$( document ).on 'click', "html, #{commentForm}, #{commentList}", (e)->
  $commentList = $(commentList)
  $current = $(e.currentTarget)
  e.stopPropagation()
  if $current.is "html"
    $commentList.slideUp()

