class UploadButton
  parentElement: null
  multiple: false
  acceptFiles: null
  name: "file"
  hoverClass: null
  focusClass: null
  input: null

  onChange: (input) =>

  constructor: (options) ->
    if not options? or not options.parentElement or not options.parentElement.nodeName
      throw new Error('parentElement must be passed as an argument and must be a DOM conatiner element')

    @[prop] = val for prop, val of options

    #make button suitable container for input
    CSS.add @parentElement, {
    position: 'relative',
    overflow: 'hidden',
    #Make sure browse button is in the right side
    #in Internet Explorer
    direction: 'ltr'
    }

    @createInput()


  createInput: () ->
    @input = input = document.createElement("input")
    input.setAttribute("multiple", "multiple") if @multiple
    input.setAttribute("accept", @acceptFiles) if @acceptFiles?
    input.setAttribute("type", "file")
    input.setAttribute("name", @name)

    CSS.add input, {
      position: 'absolute',
      # in Opera only 'browse' button
      # is clickable and it is located at
      # the right side of the input
      right: 0,
      top: 0,
      fontFamily: 'Arial',
      # 4 persons reported this, the max values that worked for them were 243, 236, 236, 118
      fontSize: '118px',
      margin: 0,
      padding: 0,
      cursor: 'pointer',
      opacity: 0
    }

    @parentElement.appendChild(input)

    Events.attach input, "change", @onChange

    ### IE and Opera, unfortunately have 2 tab stops on file input
    which is unacceptable in our case, disable keyboard access ###
    input.setAttribute('tabIndex', "-1") if window.attachEvent

    return input;

  get_input: () -> return @input
