class UploadHandlerXHR extends UploadHandlerBase
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
    xhr.setRequestHeader("Cache-Control", "no-cache")

    if (@encoding == 'multipart')
      formData = new FormData()
      formData.append(file.get_name(), file.file)
      file.file = formData
    else
      xhr.setRequestHeader("Content-Type", "application/octet-stream")
      #NOTE: return mime type in xhr works on chrome 16.0.9 firefox 11.0a2
      xhr.setRequestHeader("X-Mime-Type",file.get_type())

    xhr.setRequestHeader(key, val) for key, val of @customHeaders

    #Send file
    xhr.send(file.file);

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
