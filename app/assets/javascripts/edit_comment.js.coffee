class window.editComment
  @allEdits = []

  @activeEdits = ()->
    @allEdits.filter ( e )->
      e.active

  @prototype.beginEdit = (func)->
    @active = true
    @$editForm.html(@new_content)
    @$comment.replaceWith(@$editForm)
    textarea = @$editForm.find('textarea')
    _this = @
    textarea.parents("form").on "submit", (e)->
      _this.active = false
      true
    textarea.on "focusout", (e)->
      if _this.active
        _this.cancel()

    func(textarea) if func?


  @prototype.cancel = ()->
    @active = false
    @$editForm.replaceWith(@snapshot)

  constructor:(klass, id, new_content)->
    @selector = ".#{klass}-#{id}"
    @new_content = new_content
    @active = false

    @$comment = $(@selector)
    @$editForm = $("<div class=inline-edit-comment-form-#{id}>")
    
    @snapshot = $(@selector).clone()

    editComment.allEdits.push(@)



    

  