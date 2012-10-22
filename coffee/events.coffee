class Events

  @events: []

  @attach: (element, type, fn) ->
    if element.addEventListener
      element.addEventListener(type, fn, false)
    else if element.attachEvent
      element.attachEvent('on' + type, fn)

  @detach: (element, type, fn) ->
    if element.removeEventListener
      element.removeEventListener(type, fn, false)
    else if element.detachEvent
      element.detachEvent('on' + type, fn)

  @preventDefault: (e) ->
    if e.preventDefault
      e.preventDefault()
    else
      e.returnValue = false

  @register: (object, event, callback) ->
    if not @events[object]
      @events[object] = []

    if not @events[object][event]
      @events[object][event] = []

    if not @events[object][event][callback]
      @events[object][event].push callback

  @unregister: (object, event, callback) ->
    if @events[object]?[event]?[callback]
      @events[object][event].splice(@events[object][event].indexOf(callback), 1)

  @trigger: (object, event, args) ->
    if @events[object]?[event]?
      callback(args) for callback in @events[object][event]
