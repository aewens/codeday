define ["jquery", "keys"], ($, K) ->
    class Events
        constructor: (edit) ->
            console.log "Initializing events..."
            @edit = edit
            @pos = 0
            $("textarea").focus()
        press: (store) ->
            self = @
            @edit.store = store
            $(document).on "keydown", (e) ->
                key = e.keyCode
                K.set(key, true)
                $("#save").text("*")
                self.edit.run(key, e)
            $(document).on "keyup", (e) ->
                key = e.keyCode
                K.set(key, false)
            
    return Events
