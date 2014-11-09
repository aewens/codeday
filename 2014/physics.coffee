class Physics
    constructor: (code, level, you, darkness) ->
        if M(code,you).all()
            @universe = code.canvas
            @world = code.ctx
            @level = level
            @unit = code.unit
            @keys = code.keyState
            @you = you
            @darkness = darkness
            @objects = []
            @mobs = []
            @blocks = level.blocks
            @last = false
            @add(@blocks)
        else throw new TypeError("There is nothing. You are nothing.")
    addMobs: (xs...) -> 
        @mobs = Mu(xs...).into(@mobs)
        @objects = Mu(xs...).into(@objects)
    add: (xs...) -> @objects = Mu(xs...).into(@objects)
    gravity: (obj) -> 
        obj.y = obj.y + (@unit / 16)
        obj.light.y = obj.light.y + (@unit / 16) if M(obj.light).bool()
    update: ->
        prev = new Vector2(@you.x, @you.y)
        @gravity(@you) unless (@you.ground or @you.jumping) and !@you.falling
        for mob in @mobs
            mob.prev = new Vector2(mob.x, mob.y)
            @gravity(mob) unless mob.ground and !mob.falling
            mob.update(@you, @unit, @world)
        @you.update(@keys, @unit, @universe)
        for b in @blocks
            for mob in @mobs
                [mx, my] = mob.collide(b)
                if mx then mob.x = mob.prev.x
                if my
                    mob.y = mob.prev.y
                    mob.ground = true
                    mob.falling = false
            [px, py] = @you.collide(b)
            if px then @you.x = prev.x
            if py
                @you.y = prev.y
                @you.ground = true
                @you.falling = false
        @you.light.update(@you.x, @you.y)
    render: ->
        self = @
        @world.clearRect(0, 0, @universe.width, @universe.height)
        @level.render(@world, @unit)
        @darkness.render(@world)
        @you.render(@world)
        @you.light.render(@world, @unit)
        @objects.map (obj) -> obj.render(self.world)
        
window.Physics = Physics
