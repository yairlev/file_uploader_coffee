class FileBase
  id: null
  input: null
  total: 0
  loaded: 0

  constructor: (@input) ->
    @id = @_generateUniqueId

  _generateUniqueId: (length) ->
    chars = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXTZabcdefghiklmnopqrstuvwxyz'.split('')
    str = ''

    for i in [0..length ? 20]
      str += chars[Math.floor(Math.random() * chars.length)]

    return str;

