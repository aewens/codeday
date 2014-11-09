class Player extends Box
    constructor: (x, y, unit) ->
        scale = unit * (3/4)
        super x, y, scale, scale, new Color(210, 50, 50)
        @ground = false
        @jumping = false
        @falling = true
        @dead = false
        @hp = 1
        @clock = 0
        @light = new Light(@)
        
    damage: (dmg) -> @hp = @hp - dmg
        
    update: (key, unit, canvas) ->
        if @dead then return
        if @hp < 1
            @dead = true
            console.log "Dead"
        # @clock = (@clock + 1) % 100
        # if @clock is 0
        #     @light.darken()
        #     @light.shrink()
        if (((key[87] or key[32]) and @ground) or @jumping) and !@falling
            if key[65] then @move(-(unit / 20),0)
            if key[68] then @move((unit / 20),0)
            @jy = @y - (unit * 2) if @jumping is false or @jy is undefined
            @ground = false
            @jumping = true
            @move(0,-(unit / 16))
            if @y <= @jy
                @jumping = false
                @falling = true
        else
            if key[65]
                @x = @x - (unit / 20)
                @falling = true
            if key[68]
                @x = @x + (unit / 20)
                @falling = true
        
        # World
        if @x <= 0 then @x = 0
        if @y <= 0 
            @y = 0
            @falling = true
            @jumping = false
        if @x + @w > canvas.width then @x = canvas.width - @w
        if @y + @h > canvas.height then @dead = true
        # you know, so you can fall off the world and die

window.Player = Player
