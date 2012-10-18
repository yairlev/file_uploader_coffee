class Events

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