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
                self.edit.run(key, K.pressed)
            $(document).on "keyup", (e) ->
                key = e.keyCode
                K.set(key, false)
            
    return Events
