define ["jquery", "keys"], ($, K) ->
    class Events
        constructor: (edit) ->
            console.log "Initializing events..."
            @edit = edit
            @pos = 0
            $("textarea").focus()
        press: ->
            self = @
            $(document).on "keydown", (e) ->
                key = e.keyCode
                K.set(key, true)
            $(document).on "keyup", (e) ->
                key = e.keyCode
                self.edit.run(key, e)
                K.set(key, false)
            
    return Events
