define ["jquery", "keys"], ($, K) ->
    class Events
        constructor: (grid) ->
            console.log "Initializing events..."
            @grid = grid
            @functions = []
            @movers  = []
            @special = []
            @fill()
            @pos = 0
            @ux = @grid.ux
            @uy = @grid.uy
            @edit = true
        fill: ->
            fs = [
                K.f1, K.f2, K.f3, K.f4, K.f5, K.f6, K.f7, K.f8, K.f9, K.f10, 
                K.f11, K.f12, K.del, K.ctrl, K.meta, K.shift, K.alt
            ]
            ss = [
                K.bquote, K.quote, K.open, K.close, K.tab, K.enter
            ]
            ms = [
                K.up, K.down, K.left, K.right
            ]
            @functions[f] = true for f in fs
            @special[s] = true for s in ss
            @movers[m]  = true for m in ms
        move: (key) ->
            switch key
                when K.up   then @pos = @pos - @ux if @pos > @ux
                when K.down then @pos = @pos + @ux
        type: (key) ->
            @pos = @pos + 1
            text = $("textarea").val()
            char = K.translate(key)
            text = "#{text}#{char}"
            $("textarea").val(text)
            @grid.type(@pos, char)
        reload: (key) ->
            window.location.reload() if K.pressed[K.ctrl] and (key is K.r)
        press: ->
            self = @
            $(document).on "keydown", (e) ->
                e.preventDefault()
                key = e.keyCode
                self.reload(key)
                $("textarea").focus() if self.edit
                self.move(key) if self.movers[key]
                self.type(key) unless self.functions[key] or self.movers[key]
                K.set(key, true)
            $(document).on "keyup", (e) ->
                key = e.keyCode
                K.set(key, false)
            
    return Events
