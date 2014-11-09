class Physics
    constructor: (code, level, you) ->
        if M(code,you).all()
            @universe = code.canvas
            @world = code.ctx
            @level = level
            @unit = code.unit
            @keys = code.keyState
            @you = you
            @objects = []
            @blocks = level.blocks
        else throw new TypeError("There is nothing. You are nothing.")
    add: (xs...) -> @objects = Mu(xs...).into(@objects)
    gravity: (obj) -> obj.y += floor(sqrt(@unit) / 2)
    update: ->
        prev = new Vector2(@you.x, @you.y)
        @gravity(@you) unless @you.ground
        @you.update(@keys, @unit, @world)
        hit = @you.collide(@blocks)
        if hit
            @you.ground = true
            @you.x = prev.x
            @you.y = prev.y
        # obj = @you.collide(@blocks)
        # if obj
        #     console.log obj
        # if obj
            # @you.ground = true
            # @you.x = prev.x
            # @you.y = prev.y
        
    render: ->
        self = @
        @world.clearRect(0, 0, @universe.width, @universe.height)
        @level.render(@world, @unit)
        @you.render(@world)
        @objects.map (obj) -> obj.render(self.world)
        
window.Physics = Physics
