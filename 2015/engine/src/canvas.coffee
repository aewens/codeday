define [
    "pappai"
], (Pappai) ->
    class Canvas
        constructor: (width, height, fullscreen) ->
            ctx = Pappai.Init(width, height, fullscreen)
            @canvas = ctx.canvas
            @ctx = ((ctx) ->
                ctx.width = ctx.canvas.width
                ctx.height = ctx.canvas.height
                ctx.drawPoly = (p, x, y) ->
                    p = p.points
                    
                    @beginPath()
                    @moveTo p[0] + x, p[1] + y
                    for i in [2...p.slice(2).length] by 2
                        @lineTo p[i] + x, p[i+1] + y
                    @closePath()
                    @stroke()
                ctx.clear = ->
                    @clearRect 0, 0, @width, @height
                ctx
            )(@canvas.getContext "2d")
            
            document.body.appendChild @canvas
        animate: (leup) ->
            rf = (-> window.requestAnimationFrame)()
            self = @
            l = (now) ->
                leup(now)
                rf l, self.canvas
            rf l, @canvas

    return Canvas
