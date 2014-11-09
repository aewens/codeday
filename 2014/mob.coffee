class Mob extends Box
    constructor: (x, y, unit, dmg) ->
        scale = unit * (3/4)
        super x, y, scale, scale, new Color(0, 0, 0)
        @dmg = M(dmg).otherwise(1)
        @ground = false
        @falling = true
        @sleeping = false
        @clock = 0
        @go = false
        @dir = 0
        @canHit = false
        @sleepTime = 1
        
    pick: -> @dir = round(random()) * 2 - 1
    
    hurt: (player) ->
        if @strike(player)
            player.damage(@dmg)
            @canHit = true
            
    sleep: ->
        @color = new Color(180, 30, 30)
        @sleeping = true
        
    wake: ->
        @color = new Color(0, 0, 0)
        @sleeping = true
        
    update: (player, unit, canvas) ->
        @clock = (@clock + 1) % 100
        @sleepTime = (@sleepTime + 1) % 500 if @sleeping
        if @clock is 0
            @go = !@go 
            @pick()
            @canHit = false
            
        if @sleepTime is 0 then @wake()
        
        if @go
            @move(@dir * (unit / 10), 0)
            @falling = true
        
        if @x < 0 then @x = 0
        if @y < 0 then @y = 0
        if @x + @w > canvas.width then @x = canvas.width - @w
        # if @y + @h > canvas.height then @y = canvas.height - @h
        
        @hurt(player) unless @canHit or @sleeping

window.Mob = Mob
