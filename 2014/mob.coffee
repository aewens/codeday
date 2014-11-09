class Mob extends Box
    constructor: (x, y) ->
        super x, y, 50, 50, new Color(0, 100, 50)
        @ground = false
        @falling = true
        
    update: (player, unit, canvas) ->
        # World
        if @x < 0 then @x = 0
        if @y < 0 then @y = 0
        if @x + @w > canvas.width  then @x = canvas.width  - @w
        if @y + @h > canvas.height then @y = canvas.height - @h

window.Mob = Mob
