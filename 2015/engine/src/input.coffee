define ->
    class InputHandler
        constructor: (@keys) ->
            @down = {}
            @pressed = {}
            
            for key of @keys
                code = @keys[key]
                @keys[code] = key
                @down[key] = false
                @pressed[key] = false
            
            self = @
            document.addEventListener "keydown", (e) ->
                keyCode = self.keys[e.keyCode]
                if keyCode
                    self.down[keyCode] = true
            
            document.addEventListener "keyup", (e) ->
                keyCode = self.keys[e.keyCode]
                if keyCode
                    self.down[keyCode] = false
                    self.pressed[keyCode] = false
        isDown: (key) ->
            @down[key]
        isPressed: (key) ->
            if @pressed[key]
                return false
            else if @down[key]
                return @pressed[key] = true
            return false
        
    return InputHandler
