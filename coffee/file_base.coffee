class FileBase
  id: null
  input: null

  constructor: (@input) ->
    @id = @_generateUniqueId

  _generateUniqueId: () ->
    return ""
