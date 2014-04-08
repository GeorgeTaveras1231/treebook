# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

popUp = $ "<div>",
 id: "edit_popup"
current_id = null




$ (args)->
	$(".delete_model").on "ajax:success", ->
		$($(this).parents(".status")[0]).fadeOut ->
		$(this).css
			display: "none"

	$( document ).on "click", ".edit_model, html, #edit_popup", (e)->
		if $(e.currentTarget).is ".edit_model"
			e.preventDefault()
			id = $(e.currentTarget).parents(".status").attr("role")
			current_id = id
			_this = this
			$.post "/statuses/#{id}/popup",(response)->
				
				popUp.appendTo($(_this).parents(".status"))
				popUp.css
					position: "absolute"
					right: $(_this).parents(".status").width()+ 10
					top: 0	
				popUp.html(response)
				popUp.fadeIn()

			e.stopPropagation()
			
		else if $(e.currentTarget).is popUp
			e.stopPropagation()
		else if $(e.currentTarget).is "html"
			popUp.fadeOut()



