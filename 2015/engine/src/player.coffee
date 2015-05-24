define [
    "pappai",
    "vector"
], (Pappai, Vector) ->
    class Player
        constructor: (@x, @y, @r, @difficulty, @color) ->
            @Reecelet = Pappai.Circle(@r).fg(@color).set(@x, @y)
            @Ewensian = new Vector(@x, @y)
            @type = true # Circle
            @real  = @Reecelet
            @logic = @Ewensian
            @collided = false
            @into = null
            
            @name = random().toString(36).substr(2, 8)
            
            @G = 5
            @gravity = new Vector(0, @G)
            @velocity = new Vector(0, 0)
            @friction = 0.9
            
            @canJump = false
            @health = 100 + ln(@difficulty+1) * 10
            @damage = 0
            @dead = false
            
            opts  =
                fcolor: "hsla(180, 100%, 50%, 0.5)"
                scolor: "hsl(200, 100%, 50%)"
                doStroke: true
            @pulsar = Pappai.Circle(@r + 5).flag(opts)
            @pulsate = false
            @pulsing = 0
            @
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
                # console.log d2, self.r
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
            # if @collided
            #     @real.fg("#ff0")
            # else
            #     @real.fg(@color)
            @collided
        pulse: (energy) ->
            @pulsar.radius = @real.radius + abs(sin(@pulsing)) * 500
            # E = k(xmh/r^(p-q))
            if floor(@pulsing * 100) % 5 is 0
                @E = 
                    k: 100
                    x: 1
                    m: 1
                    h: @health
                    r: @pulsar.radius
                    p: 2
                    q: 0
                @damage = energy.calc(@E.k, @E.x, @E.m, @E.h, @E.r, @E.p, @E.q)
        update: (map, energy) ->
            if @health > 0
                # console.log @health
                @health = @health + 1 if @time % 100 is 0
                @real.fg(@color) if @real.get("fcolor") != @color
                @dead = false if @dead
                
                @velocity = @velocity.scale(@friction)
                @logic = @logic.add(@gravity).add(@velocity)
                
                @pulse(energy) if @pulsate and energy.E > energy.reset
                
                # After future logic
                if @collide(map)
                    dir = @into.logic.sub(@logic).dot(@gravity)
                    if dir >= 39
                        # gravity = new Vector(0, @velocity.y)
                        @logic = @logic.sub(@gravity)
                        @canJump = true
                    else if dir <= -39
                        # Bottom
                    else
                else
                    @canJump = false
                    
                @real.set(@logic.x, @logic.y)
            else
                @dead = true
                @real.fg("hsla(0, 0%, 0%, 0.5)")
        render: ->
            @real.render()

    return Player
