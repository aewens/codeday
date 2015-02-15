define ["jquery"], ($) ->
    class Storage
        constructor: (fileName, fileText, fileList, fileInfo, fileSave) ->
            localStorage["mu_files"] = 
                localStorage["mu_files"] || JSON.stringify([])
            @fileName = fileName
            @fileText = fileText
            @fileList = fileList
            @fileInfo = fileInfo
            @fileSave = fileSave
            
            @
        loadFile: (filename) ->
            ret = null
            store = JSON.parse(localStorage["mu_files"])
            for s in store
                ret = s if s.name is filename
            @fileInfo.html(ret.name)
            @fileSave.html("*")
            @fileText.html(ret.text)
        displayEntries: (entries) ->
            @fileList.html("")
            for entry in entries
                continue if entry.name is ""
                li   = $("<li/>")
                li.addClass("file")
                
                link = $("<a/>")
                link.html(entry.name)
                link.addClass("edit-file")
                li.append(link)
                
                delLink = $("<a/>")
                delLink.html(" [x]")
                delLink.addClass("del-file")
                li.append(delLink)
                
                @fileList.append(li)
                
                self = @
                link.on "click", (e) ->
                    e.preventDefault()
                    self.loadFile(entry.name)
                    
                delLink.on "click", (e) ->
                    e.preventDefault()
                    self.deleteFile(entry.name)
        listFiles: ->
            entries = JSON.parse(localStorage["mu_files"])
            @displayEntries(entries.sort().reverse())
        saveFile: (filename, text) ->
            store = JSON.parse(localStorage["mu_files"])
            store.push({name: filename, text: text})
            localStorage["mu_files"] = JSON.stringify(store)
            @fileSave.html("Saved")
        deleteFile: (filename) ->
            store = JSON.parse localStorage["mu_files"]
            list = []
            for s in store
                list.push(s) unless s.name is filename
            localStorage["mu_files"] = JSON.stringify list
            @listFiles()
            @fileSave.html("Deleted")
    
    return Storage
