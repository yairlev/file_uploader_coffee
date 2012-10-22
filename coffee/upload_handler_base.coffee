class UploadHandlerBase
  constructor: (options) ->
      @[prop] = val for prop, val of options

  debug: false
  action: '/server/upload'
  protocol: 'POST'
  maxConcurrent: 1
  autoUpload: false
  customHeaders: {}
  encoding: null
  allowMultiple: false
  files: {}
  params: {}

  onStart: (file) ->
  onProgress: (file) ->
  onComplete: (file) ->
  onCancel: (file) ->

  add: (file) ->
    @files[file.id] = file;

  _buildQueryString: (jsonObj) ->


