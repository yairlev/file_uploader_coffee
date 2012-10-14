import window.Events
;
class window.FileUploader
  constructor: (options) ->
    @[prop] = val for prop, val of options

    #Create appropriate file-upload handler
    @fileUploadHandler = UploadHandlerXHR.isSupported ? new UploadHandlerXHR : new UploadHandlerForm


  debug: false
  action: '/server/upload'
  parentElement: null
  params: {}
  customHeaders: {}
  button: null
  sizeLimit: 0
  minSizeLimit: 0
  message: null
  filesInProgress: 0,
  fileUploadHandler: null

  onSubmit: (id, fileName) ->
  onComplete: (id, fileName, responseJSON) ->
  onCancel: (id, fileName) ->
  onInputChange: (input) ->



class UploadHandlerBase
  constructor: (options) ->
    @[prop] = val for prop, val of options

  debug: false
  action: '/server/upload'
  protocol: 'POST'
  maxConnections: 999
  encoding: null
  queue: []
  params: {}
  customHeaders: []


  onStart: (file) ->
  onProgress: (file) ->
  onComplete: (file) ->
  onCancel: (file) ->

  add: (file) ->

  _buildQueryString: (jsonObj) ->



class UploadHandlerXHR extends UploadHandlerBase

  files: {}
  xhrs: {}

  @isSupported: () ->
    input = document.createElement('input')
    input.type = 'file'
    xmlHttpRequest = new XMLHttpRequest()
    return input.multiple? && File? && FormData? && xmlHttpRequest? && xmlHttpRequest.upload?

  upload: (file) ->
    throw new Error() if file isnt XHRFile
    xhr = new XMLHttpRequest()

    xhr.upload.onprogress = (e) =>
      if (e.lengthComputable)
        file.loaded = e.loaded
        @onProgress(file)

    xhr.onreadystatechange = =>
      if (xhr.readyState == 4)
        xhr = null
        @onComplete(file)

    @files[file.id] = file
    @xhrs[file.id] = xhr

    querystring = "#{encodeURIComponent key}=#{encodeURIComponent val}" for key, val of @params

    action = @action

    action = if /\?$/.test(action)
                "#{action}#{querystring}"
             else if /\?.+&$/.test(action)
                "#{action}#{querystring}"
             else if /\?/.test(action)
                "&#{action}#{querystring}"
             else
              "?#{action}#{querystring}"


    xhr.open(@protocol, action, true)
    xhr.setRequestHeader("X-Requested-With", "XMLHttpRequest")
    xhr.setRequestHeader("X-File-Name", encodeURIComponent file.get_name())

    if (@encoding == 'multipart')
      formData = new FormData()
      formData.append(file.get_name(), file.file)
      file.file = formData
    else
      xhr.setRequestHeader("Content-Type", "application/octet-stream")
      #NOTE: return mime type in xhr works on chrome 16.0.9 firefox 11.0a2
      xhr.setRequestHeader("X-Mime-Type",file.get_type())

    xhr.setRequestHeader(key, val) for key, val of @customHeaders

    xhr.send(file.file);
    return @

  onComplete: (file) =>
    if file is XHRFile
      @options.onProgress file

      xhr = @xhrs[file.id]
      if xhr? and xhr.status == 200

        try
          file.response = eval("(" + xhr.responseText + ")")
        catch err
          file.response = {}

      @options.onComplete file
    else #error
      @options.onError(file)
      @options.onComplete(file)

    @xhrs[file.id] = null
    @files[file.id] = null


class UploadHandlerForm extends UploadHandlerBase

class FileBase
  constructor: (options) ->
    @id = _generateUniqueId
    @[prop] = val for prop, val of options

  id: null
  file: null

  _generateUniqueId: () ->
    return ""

class XHRFile extends FileBase
  get_name: -> return @file.name ? @file.fileName
  get_size: -> return @file.size ? @file.fileSize
  get_type: -> return @file.type ? @file.fileType


class InputFile extends FileBase


class UploadButton
  element: null
  multiple: false
  acceptFiles: null
  name: "file"
  hoverClass: null
  focusClass: null

  onChange: (input) =>

  createInput: () ->
    input = document.createElement("input")
    if @multiple
      input.setAttribute("multiple", "multiple")

    if @acceptFiles?
      input.setAttribute("accept", @acceptFiles)

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
      opacity: 0,
      cursor: 'pointer'
    }

  #@element.appendChild(input)

  #Events.attach input, "change", @onChange



class window.CSS
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



class window.Events
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