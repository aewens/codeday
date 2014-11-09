class Physics
    constructor: (code, level, you, darkness, light) ->
        if M(code,you).all()
            @universe = code.canvas
            @world = code.ctx
            @level = level
            @unit = code.unit
            @keys = code.keyState
            @you = you
            @darkness = darkness
            @light = light
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
    gravity: (obj) -> obj.y = obj.y + (@unit / (16))
    update: ->
        prev = new Vector2(@you.x, @you.y)
        @gravity(@you,1) unless (@you.ground or @you.jumping) and !@you.falling
        for mob in @mobs
            mob.prev = new Vector2(mob.x, mob.y)
            @gravity(mob, 1) unless mob.ground and !mob.falling
            mob.update(@you, @unit, @world)
        @you.update(@keys, @unit, @world)
        @light.update(@you)
        for b in @blocks
            for mob in @mobs
                if mob.collide(b)[1]
                    mob.y = mob.prev.y
                    mob.ground = true
                    mob.falling = false
            [x, y] = @you.collide(b)
            if x
                @you.x = prev.x
            if y
                @you.y = prev.y
                @you.ground = true
                @you.falling = false
        
    render: ->
        self = @
        @world.clearRect(0, 0, @universe.width, @universe.height)
        @level.render(@world, @unit)
        @darkness.render(@world)
        @you.render(@world)
        @light.render(@world)
        @objects.map (obj) -> obj.render(self.world)
        
window.Physics = Physics
