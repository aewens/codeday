define ["jquery"], ($) ->
    class FileSystem
        constructor: (fileName, fileText, fileList, fileSave) ->
            @reqFS = window.requestFileSystem || window.webkitRequestFileSystem
            @fileName = fileName
            @fileText = fileText
            @fileList = fileList
            @fileSave = fileSave
            @files = []
            return if @reqFS then @initFS() else null
        errors: (err) ->
            message = ""
            switch err
                when FileError.SECURITY_ERR
                    message = "Security Error"
                when FileError.NOT_FOUND_ERR
                    message = "Not Found Error"
                when FileError.QUOTA_EXCEEDED_ERR
                    message = "Quota Exceeded Error"
                when FileError.INVALID_MODIFICATION_ERR
                    message = "Invalid Modification Error"
                when FileError.INVALID_STATE_ERR
                    message = "Invalid State Error"
                else
                    message = "Unknown Error"
            console.log(message)
        initFS: ->
            # navigator.webKitPersistentStorage.requestQuota
            self = @
            @reqFS window.TEMPORARY, Math.pow(2,20), # 1MB
            ((fs) ->
                self.fs = fs
                self.saveFileListener()
                self.listFiles()
            ), @errors
        loadFile: (filename) ->
            self = @
            @fs.root.getFile filename, {}, ((fileEntry) ->
                fileEntry.file ((file) ->
                    reader = new FileReader()
                    reader.onload = (e) ->
                        self.fileName.val(filename)
                        self.fileText.val(@result)
                    reader.readAsText(file)
                ), self.errors
            ), @errors
        displayEntries: (entries) ->
            @fileList.html("")
            for entry in entries
                li   = $("<li/>")
                li.addClass("file")
                
                link = $("<a/>")
                link.html(entry.name)
                link.addClass("edit-file")
                li.append(link)
                
                delLink = $("<a/>")
                delLink.html("[x]")
                delLink.addClass("del-file")
                li.append(delLink)
                
                fileList.append(li)
                
                link.on "click", (e) ->
                    e.preventDefault()
                    loadFile(entry.name)
                    
                delLink.on "click", (e) ->
                    e.preventDefault()
                    deleteFile(entry.name)
        listFiles: ->
            dirReader = @fs.root.createReader()
            entries = []
            self = @
            
            fetchEntries = ->
                dirReader.readEntries ((results) ->
                    unless results.length
                        self.displayEntries(entries.sort().reverse())
                    else
                        entries = entries.concat(results)
                        fetchEntries()
                ), errors
            fetchEntries()
        saveFile: (filename, text)->
            self = @
            @fs.root.getFile filename, {create:true}, ((fileEntry) ->
                fileEntry.createWriter ((fileWriter) ->
                    fileWriter.onwriteend = (e) ->
                        self.listFiles()
                        self.fileName.val("")
                        self.fileText.val("")
                        self.fileSave.html("Saved")
                    fileWriter.onerror = (e) ->
                        console.log "Write error: #{e.toString()}"
                        alert "File save error!"
                    textBlob = new Blob([text], {type: "text/plain"})
                    fileWriter.write(textBlob)
                ), self.errors
            ), @errors
        deleteFile: (filename) ->
            self = @
            @fs.root.getFile filename, {create:false}, ((fileEntry) ->
                fileEntry.remove ((e) ->
                    self.listFiles()
                    self.fileSave.html("Deleted")
                ), self.errors
            ), @errors
        saveFileListener: ->
            # Listener to save file
            # @saveFile(filename, text)
    
    return FileSystem
