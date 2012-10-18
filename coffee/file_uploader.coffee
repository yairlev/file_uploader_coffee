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
  maxConcurrent: 1

  constructor: (options) ->
    @[prop] = val for prop, val of options

    #Create appropriate file-upload handler
    @fileUploadHandler = UploadHandlerXHR.isSupported ? new UploadHandlerXHR : new UploadHandlerForm

    @set_parentElement @parentElement

  #input DOM change event filred
  _onInputChange: (input) ->
    #lets create a wrapper for the input
    file = new XHRFile input if input?
    @fileUploadHandler.add file


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
      @uploadButton = new UploadButton(options.parentElement);
      @uploadButton.onChange @_onInputChnage

  onSubmit: (id, file) ->
  onComplete: (id, file, responseJSON) ->
  onCancel: (id, file) ->
  onFileSelect: (file) ->
  onProgress: (file, loaded, total) ->
  onError: (file) ->














