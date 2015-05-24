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
            @into = null
            
            @G = 5
            @gravity = new Vector(0, @G)
            @velocity = new Vector(0, 0)
            @friction = 0.9
        move: (x, y) ->
            @velocity = @velocity.add2(x, y)
        collide: (map) ->
            w = map.w * map.size
            h = map.h * map.size
            if @logic.x < @r
                @logic = new Vector(@r, @logic.y)
            if @logic.x >= w - @r
                @logic = new Vector(w - @r - 1, @logic.y)
            if @logic.y < @r
                @logic = new Vector(@logic.x, @r)
            if @logic.y >= h - @r
                @logic = new Vector(@logic.x, h - @r - 1)    
            
            self = @
            logic = @logic
            ctc = (c, r) ->
                self.r + r > c.sub(self.logic).mag()
            cts = (x, y, s) ->
                cx = clamp(self.logic.x, x, x + s)
                cy = clamp(self.logic.y, y, y + s)
                c  = new Vector(cx, cy)
                d2 = ceil(self.logic.sub(c).mag())
                console.log d2, self.r
                d2 < self.r
                
            collided = false
            for object in map.world
                continue if collided
                logic = object.logic
                real = object.real
                objx = real.x
                objy = real.y
                objs = real.side if real.side?
                objr = real.radius if real.radius?
                collided = if object.type
                                ctc(logic, objr)
                            else
                                cts(objx, objy, objs)
                @into = object if collided
            @collided = collided
            if @collided
                @real.fg("#ff0")
            else
                @real.fg(@color)
            @collided
        update: (world) ->
            @velocity = @velocity.scale(@friction)
            @logic = @logic.add(@gravity).add(@velocity)
            # After future logic
            if @collide(world)
                dir = @into.logic.sub(@logic).dot(@gravity)
                if dir >= 39
                    # gravity = new Vector(0, @velocity.y)
                    @logic = @logic.sub(@gravity)
                else if dir <= -39
                    # Bottom
                else
                    # Side
                    
            @real.set(@logic.x, @logic.y)
        render: ->
            @real.render()

    return Player
