# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# these are event declarations for interfaces to comments

statusForm = ".inline-status-form textarea"
commentForm = ".inline-comment-form textarea"
editForm = "[class^=inline-edit-comment-form-] textarea"
commentList = ".comment-list"

$statusForm = $(".inline-status-form textarea")
$html = $("html")

# on focus in of the status form, display the 'Post' submit button
$html.on 'focusin', statusForm, (e)->
  $current = $(e.currentTarget)
  $current.parents("form").children(".form-actions").css
    display: "inherit"

# on focus out of the status form, hide the 'Post' button,
# and reset the height of the textarea if it was altered
$html.on 'focusout', statusForm, (e)->
  $current = $(e.currentTarget)
  if $current.val() is ""
    $current.parents("form").children(".form-actions").css
      display: "none"
    $current.css
      height: "initial"


# submit a comment if the user presses enter in the comment textarea
$html.on 'keydown', "#{commentForm}, #{editForm}", (e)->
  $current = $(e.currentTarget)
  if e.shiftKey is false and e.which is 13 #press enter
    $current.parents("form").trigger('submit')
    $current.prop('value', '')
    $current.trigger('blur')

# display the comment list for a status when focused on
# its corresponding comment textarea
$html.on 'focusin', commentForm, (e)->
  $current = $(e.currentTarget)
  $currentCommentList = $current.parents("[class^='status-']").children(".comment-list")
  $(".comment-list").not($currentCommentList).slideUp()
  $currentCommentList.slideDown()

# hide all of the comment lists when click outside of the status
# and comment list
$( document ).on 'click', "html, #{commentForm}, #{commentList}", (e)->
  $commentList = $(commentList)
  $current = $(e.currentTarget)
  e.stopPropagation()
  if $current.is "html"
    $commentList.slideUp()


