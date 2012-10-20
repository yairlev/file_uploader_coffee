class FileUploader

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
  uploadButton: null,
  allowMultiple: false,
  maxConcurrent: 1,
  callbacks: []

  constructor: (options) ->
    @[prop] = val for prop, val of options

    #Create appropriate file-upload handler
    @fileUploadHandler = if UploadHandlerXHR.isSupported()
      new UploadHandlerXHR()
    else
      new UploadHandlerForm()

    @set_parentElement @parentElement

  #input DOM change event filred
  _onInputChange: (input) =>
    #lets create a wrapper for the input
    if input?
      file = new XHRFile input
      @fileUploadHandler.add file
      Events.trigger(@, 'submit')

  upload: (fileId) ->
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


  onSubmit: (callback) ->
    Events.register(@, 'submit', callback);

  onComplete: (id, file, responseJSON) ->
  onCancel: (id, file) ->
  onProgress: (file, loaded, total) ->
  onError: (file) ->














