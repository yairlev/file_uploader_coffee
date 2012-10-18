class XHRFile extends FileBase
  get_name: -> return @file.name ? @file.fileName
  get_size: -> return @file.size ? @file.fileSize
  get_type: -> return @file.type ? @file.fileType
