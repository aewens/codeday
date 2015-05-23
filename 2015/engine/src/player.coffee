define [
    "pappai",
    "vector"
], (Pappai, Vector) ->
    class Player
        constructor: (@x, @y, @r, @color) ->
            @Reecelet = Pappai.Circle(@r).fg(@color).set(@x, @y)
            @Ewensian = new Vector(@x, @y)
            @type = true # Circle
            @real  = @Reecelet
            @logic = @Ewensian
            @collided = false
            @
        collide: (world) ->
            # world is a list of vectors
            self = @
            ctc = (c, r) ->
                self.r + r > c.sub(self.logic).mag()
            cts = (x, y, s) ->
                cx = clamp(self.logic.x, x, x + s)
                cy = clamp(self.logic.y, y, y + s)
                c  = new Vector(cx, cy)
                d2 = self.logic.sub(c).mag()
                console.log d2
                d2 < self.r
            for object in world
                logic = object.logic
                real = object.real
                objx = real.x
                objy = real.y
                objs = real.side if real.side?
                objr = real.radius if real.radius?
                @collided = if object.type
                                ctc(logic, objr)
                            else
                                cts(objx, objy, objs)
                if @collided
                    @color = "#0f0"
                    @real.fg(@color)
                else
                    @color = "#00f"
                    @real.fg(@color)

    return Player
