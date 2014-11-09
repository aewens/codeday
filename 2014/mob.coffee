class Mob extends Box
    constructor: (x, y, unit) ->
        scale = unit * (3/4)
        super x, y, scale, scale, new Color(0, 0, 0)
        @ground = false
        @falling = true
        @clock = 0
        @go = false
        @dir = 0
        @canHit = false
        
    pick: -> @dir = round(random()) * 2 - 1
    
    hurt: (player) ->
        if @strike(player)
            player.damage(1)
            @canHit = true
        
    update: (player, unit, canvas) ->
        @clock = (@clock + 1) % 100
        if @clock is 0
            @go = !@go 
            @pick()
            @canHit = false
        
        if @go
            @move(@dir * (unit / 10), 0)
            @falling = true
        
        if @x < 0 then @x = 0
        if @y < 0 then @y = 0
        if @x + @w > canvas.width  then @x = canvas.width  - @w
        # if @y + @h > canvas.height then @y = canvas.height - @h
        
        @hurt(player) unless @canHit

window.Mob = Mob
