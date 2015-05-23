define [], () ->
    class Engine
        constructor: (@ctx) ->
            @canvas = @ctx.canvas
        animate: (leup) ->
            rf = (-> window.requestAnimationFrame)()
            self = @
            l = ->
                leup()
                rf l, self.canvas
            rf l, self.canvas
            
    return Engine
