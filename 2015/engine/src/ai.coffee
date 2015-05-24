define [
    "pappai",
    "vector",
    "player"
], (Pappai, Vector, Player) ->
    class AI
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
            
            @canJump = false
            @health = 10
            @dead = false
        move: (x, y) ->
            @velocity = @velocity.add2(x, y)
        collide: (map, player, others) ->
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
                d2 < self.r
                
            collided = false
            hit = false
            everything = [player].concat(others).concat(map.world)
            for object in everything
                continue if collided
                if object instanceof Player and object.pulsate
                    pulsar = new Vector(object.pulsar.x, object.pulsar.y)
                    hit = ctc(pulsar, object.pulsar.radius)
                else
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
            if @into instanceof Player
                player.health = player.health - 1 if player.health > 0
            @health = @health - player.damage if hit and @health > 0
            # if @collided
            #     @real.fg("#ff0")
            # else
            #     @real.fg(@color)
            @collided
        update: (map, player, others) ->
            if @health > 0
                @real.fg(@color) if @real.get("fcolor") != @color
                
                attract = player.logic.sub(@logic)
                if attract.mag() < 250
                    lr = if attract.x > 0 then 1 else -1
                    ud = if attract.y < 0 and @canJump then -5 else 0
                    
                    # Hack to fix underground bug
                    ud = if @logic.y >= map.h * map.size - @r * 2 then -20 else ud
                    
                    @velocity = @velocity.add2(lr, ud)
                else
                    @velocity = new Vector(0, 0)
                
                @velocity = @velocity.scale(@friction)
                @logic = @logic.add(@gravity).add(@velocity)
                # After future logic
                if @collide(map, player, others)
                    dir = @into.logic.sub(@logic).dot(@gravity)
                    if dir >= 35
                        # gravity = new Vector(0, @velocity.y)
                        @logic = @logic.sub(@gravity)
                        @canJump = true
                    else if dir <= -35
                        # Bottom
                    else
                        @logic = @logic.sub(@velocity).sub(@gravity)
                else
                    @canJump = false
                @real.set(@logic.x, @logic.y)
            else
                @dead = true
                @real.fg("hsla(0, 0%, 0%, 0.5)")
        render: ->
            @real.render()

    return AI
