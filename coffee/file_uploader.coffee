class FileUploader

  debug: false
  action: '/server/upload',
  protocol: 'POST',
  autoUpload: true,
  parentElement: null
  params: {}
  customHeaders: {}
  button: null
  maxSize: 0
  minSize: 0
  message: null
  filesInProgress: 0
  fileUploadHandler: null
  uploadButton: null
  allowMultiple: false
  maxConcurrent: 1
  callbacks: []

  constructor: (options) ->
    @[prop] = val for prop, val of options

    #Create appropriate file-upload handler
    @fileUploadHandler = if UploadHandlerXHR.isSupported()
      new UploadHandlerXHR({
        debug: @debug,
        action: @action,
        protocol: @protocol,
        autoUpload: @autoUpload,
        customHeaders: @customHeaders,
        maxConcurrent: @maxConcurrent,
        allowMultiple: @allowMultiple,
        maxConcurrent: @maxConcurrent
      })
    else
      new UploadHandlerForm({
        debug: debug,
        action: @action,
        protocol: @protocol,
        autoUpload: @autoUpload,
        customHeaders: @customHeaders,
        maxConcurrent: @maxConcurrent,
        allowMultiple: @allowMultiple,
        maxConcurrent: @maxConcurrent
        })

    @set_parentElement @parentElement

  #input DOM change event filred
  _onInputChange: (input) =>
    #lets create a wrapper for the input
    if input?
      #create an appropriate file wrapper
      file = if @fileUploadHandler is UploadHandlerXHR new XHRFile input else new InputFile input
      @fileUploadHandler.add file
      Events.trigger(@, 'submit', file)

  upload: (fileId, params) ->
    @fileUploadHandler.upload fileId

  uploadAll: () ->
    @fileUploadHandler uploadAll

  cancel: (fileId) ->
    @fileUploadHandler.cancel fileId

  removeFile: (fileId) ->
    @fileUploadHandler.removeFile fileId

  clearAllFiles: () ->
    @fileUploadHandler.clearAllFiles

  set_parentElement: (element) ->
    if element?
      @parentElement = element
      @uploadButton = new UploadButton({parentElement: element});
      @uploadButton.onChange = @_onInputChange

  ###
  Supported events: submit, beforeUpload, complete, error, progress, cancel
  ###
  on: (event, callback) ->
    Events.register(@, 'submit', callback);

  #onSubmit: (callback) ->
   # Events.register(@, 'submit', callback);

  #onComplete: (id, file, responseJSON) ->
  #onCancel: (id, file) ->
  #onProgress: (file, loaded, total) ->
  #onError: (file) ->














