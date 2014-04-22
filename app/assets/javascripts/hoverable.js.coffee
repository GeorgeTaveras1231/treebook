class window.Hoverable


  _argumentParser = (args...)->
    @selector = args[0]
    if args[1]?
      @partial_path = args[1]["partial_path"]
      @content = args[1]["content"]
      @data = args[1]["data"]
      @class = args[1]["class"]
    @
  #_argumentParser; end

  _findCorrespondingInstance = (currentTarget)->
    Hoverable.all_hoverable_objects.filter(( i )->
      $(currentTarget).is i.selector
    )[0]

  _findCorrespondingSelector = (currentTarget)->
    _findCorrespondingInstance(currentTarget).selector

  _mouseOverFunction = ( e )->
    $current = $(e.currentTarget)
    all_selectors = Hoverable.all_selectors
    hoverable_instance = _findCorrespondingInstance( e.currentTarget )

    if hoverable_instance?
      Hoverable.mouseInDefault(hoverable_instance, e.currentTarget)
    else
      Hoverable.mouseOutDefault()
    e.stopPropagation()
  ##_mouseOverFunction; end

  @all_hoverable_objects = []
  @all_selectors = []
  @content_mapping = {}
  @cachedPartials = {}

  # base css
  # at the moment the hoverbox requires a css class
  # specified at initialization for custom styling  
  @content_box = $ '<div>', 
    css: 
      display: "none"
      position: "fixed"
      padding: 10;
      width: "auto"
      height: "auto"
      zIndex: 5000
  .appendTo('html')
 
  @mouseInDefault = (instance, currentTarget)->
    Hoverable.content_box.stop(true,true).removeClass (i, oldClass)->
        oldClass
    Hoverable.content_box.addClass(instance.class)

    _default = (content)->  
      Hoverable.content_box
      .html(content)
      .fadeIn(100)
      
    unless instance.loadPartial currentTarget, _default
      _default(Hoverable.content_mapping[instance.selector])
    
  #mouseInDefault; end

  @mouseOutDefault = ->
    Hoverable.content_box
    .fadeOut(100)
  #mouseOutDefault; end
  
  @hoverable_mousemove_event = $( document ).on "mousemove", ( e )->
    Hoverable.content_box.css
      left: e.clientX + 10
      top: e.clientY + 10
  #hoverable_mousemove_event; end


  @cachePartial = (currentTarget, response)->
    selector = _findCorrespondingSelector(currentTarget)
    hoverableId = currentTarget.dataset.hoverableId
    @cachedPartials[selector][hoverableId] = response
  #@cachePartial; end

  @clearCache = (key, id)->
    delete @cachedPartials[key][id]
  #clearCache

  @prototype.loadPartial = (currentTarget, func, forceLoad = false)->
    hoverableId = currentTarget.dataset.hoverableId
    selector = _findCorrespondingSelector(currentTarget)
    if typeof @data is "function"
      data = @data(hoverableId, currentTarget)
    else
      data = {data: hoverableId}
    
    unless typeof @partial_path is "undefined"
      unless Hoverable.cachedPartials[selector][hoverableId]? && forceLoad is false
        $.get @partial_path, data, ( response )->
          Hoverable.cachePartial(currentTarget, response)
          func(Hoverable.cachedPartials[selector][hoverableId]) if func?
      else
        func(Hoverable.cachedPartials[selector][hoverableId]) if func?
      
    else
      null
  #prototype.loadPartial; end

  constructor: (args...)->
    _argumentParser.call @, args...

    Hoverable.content_mapping[@selector] = @content if @content?
    Hoverable.all_selectors.push(@selector)
    Hoverable.all_hoverable_objects.push(@)
    selector_string = Hoverable.all_selectors.concat('html').join(', ')

    Hoverable.cachedPartials[@selector] = {} if @partial_path?

    $( document ).on "mouseover", selector_string, _mouseOverFunction

  #constructor; end

