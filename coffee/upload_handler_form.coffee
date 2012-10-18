class UploadHandlerForm extends UploadHandlerBase

class FileBase
  constructor: (options) ->
    @id = _generateUniqueId
    @[prop] = val for prop, val of options

  id: null
  file: null

  _generateUniqueId: () ->
    return ""
