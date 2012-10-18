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


