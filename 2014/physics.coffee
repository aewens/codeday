class Physics
    constructor: (code, level, you, darkness, evpg) ->
        if M(code,you).all()
            @universe = code.canvas
            @world = code.ctx
            @level = level
            @unit = code.unit
            @keys = code.keyState
            @you = you
            @darkness = darkness
            @evpg = evpg
            @objects = []
            @mobs = []
            @blocks = level.blocks
            @win = false
            @add(@blocks)
        else throw new TypeError("There is nothing. You are nothing.")
    addMobs: (xs...) -> 
        @mobs = Mu(xs...).into(@mobs)
        @objects = Mu(xs...).into(@objects)
    add: (xs...) -> @objects = Mu(xs...).into(@objects)
    gravity: (obj) -> 
        obj.y = obj.y + (@unit / 16)
        obj.light.y = obj.light.y + (@unit / 16) if M(obj.light).bool()
    update: (game) ->
        if @you.dead
            @evpg.set("end") unless M(@evpg.text).bool()
            @evpg.update()
            return
        if @win
            @evpg.set("win") unless M(@evpg.text).bool()
            @evpg.update()
            return
        prev = new Vector2(@you.x, @you.y)
        unless (@you.ground or @you.jumping) and !@you.falling
            @gravity(@you)
        for mob in @mobs
            mob.prev = new Vector2(mob.x, mob.y)
            @gravity(mob) unless mob.ground and !mob.falling
            mob.update(@you, @unit, @world)
        @you.update(@keys, @unit, @universe)
        for b in @blocks
            for mob in @mobs
                [ign, mx, my] = mob.collide(b)
                if mx 
                    unless ign
                        mob.x = mob.prev.x
                if my
                    unless ign
                        mob.y = mob.prev.y
                        mob.ground = true
                        mob.falling = false
            [ign, px, py] = @you.collide(b)
            if px
                unless ign
                    @you.x = prev.x
                    @you.falling = true
                    @you.jumping = false
            if py
                if b.win
                    console.log "You win!"
                    @win = true
                unless ign
                    @you.y = prev.y
                    @you.ground = true
                    @you.falling = false
        @you.light.update(@you.x, @you.y)
    render: ->
        if @you.dead
            @evpg.set("end") unless M(@evpg.text).bool()
            @evpg.render()
            return
        if @win
            @evpg.set("win") unless M(@evpg.text).bool()
            @evpg.render()
            return
        self = @
        @world.clearRect(0, 0, @universe.width, @universe.height)
        @level.render(@world, @unit)
        @darkness.render(@world)
        @objects.map (obj) -> obj.render(self.world)
        @you.render(@world)
        @you.light.render(@world, @unit)
        
window.Physics = Physics
