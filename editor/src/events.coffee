define ["keys"], (K) ->
    class Events
        constructor: (grid) ->
            console.log "Initializing events..."
            @grid = grid
            @special = []
            @fillSpecial()
            @pos = 0
        fillSpecial: ->
            nums = [
                K.f1, K.f2, K.f3, K.f4, K.f5, K.f6, K.f7, K.f8, K.f9, K.f10, 
                K.f11, K.f12, K.bquote, K.quote, K.open, K.close, K.tab, 
                K.enter, K.del, K.ctrl, K.meta, K.shift, K.alt, K.up, K.down, 
                K.left, K.right
            ]
            @special[n] = true for n in nums
        type: (key) ->
            @pos = @pos + 1
            @grid.type(@pos, K.translate(key))
        reload: (key) ->
            window.location.reload() if K.pressed[K.ctrl] and (key is K.r)
        press: ->
            self = @
            $(document).on "keydown", (e) ->
                e.preventDefault()
                key = e.keyCode
                self.reload(key)
                self.type(key) unless self.special[key]
                K.set(key, true)
            $(document).on "keyup", (e) ->
                key = e.keyCode
                K.set(key, false)
            
    return Events
