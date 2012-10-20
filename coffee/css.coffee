class CSS
  @add : (element, styles) ->
    if styles.opacity?
        if typeof element.style.opacity isnt "string" and element.filters?
          styles.filter = "alpha(opacity='#{Math.round(100 * styles.opacity)}')"

    for key, value of styles
      element.style[key] = value

  @hasClass: (element, name) ->
    return new RegExp("(?:^|\\s)#{name}(?=\\s|$)").test(element.className)

  @addClass: (element, name) ->
    if not CSS.hasClass element, name
      element.className += " #{name}"

  @removeClass: (element, name) ->
    element.className = element.className.replace( new RegExp("(?:^|\\s*)#{name}(?=\\s|$)") , '')

