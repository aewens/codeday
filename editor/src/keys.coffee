define ["keycodes", "translate"], (codes, chars) ->
    class Keys
        constructor: ->
            console.log "Loading keys..."
            @mac    = (window.navigator.platform.indexOf("Mac") != -1)
            @loadKeys()
            @pressed = []
        loadKeys: ->
            @[k] = v for k, v of codes
            if @mac
                ctrl = @ctrl
                meta = @meta
                @ctrl = meta
                @meta = ctrl
        translate: (i) -> chars[i]
        set: (k, v) ->
            @pressed[k] = v
            fn = arguments[2]
            fn.call(@pressed) if fn != undefined
            @
            
    return new Keys
