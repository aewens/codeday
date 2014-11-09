class Player extends Box
    constructor: (x, y) ->
        super x, y, 50, 50, new Color(210, 50, 50)
        @ground = false
        @jumping = false
        @falling = true
        
    update: (key, unit, canvas) ->
        if (((key[87] or key[32]) and @ground) or @jumping) and !@falling
            if key[65] then @move(-(unit / 20),0)
            if key[68] then @move((unit / 20),0)
            @jy = @y - (unit * 1.5) if @jumping is false or @jy is undefined
            @ground = false
            @jumping = true
            @move(0,-(unit / 8))
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
        if @x < 0 then @x = 0
        if @y < 0 then @y = 0
        if @x + @w > canvas.width  then @x = canvas.width  - @w
        if @y + @h > canvas.height then @y = canvas.height - @h

window.Player = Player
