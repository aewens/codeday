class Player extends Box
    constructor: (x, y) ->
        super x, y, 50, 50, new Color(210, 13, 50)
        @ground = false
        @jumping = false
        @hit = false
        
    update: (key, unit, canvas) ->
        if key[65] then @x = @x - floor(sqrt(sqrt(unit)))
        if key[68] then @x = @x + floor(sqrt(sqrt(unit)))
        if (key[87] and @ground) or (key[32] and @ground) or @jumping
            @jy = @y - (unit * 1.5) if @jy is @y or @jy is undefined
            @jumping = true
            @ground = false
            @y = @y - floor(sqrt(unit))
            if @hit
                @jumping = false
                @jy = @y
            if @y <= @jy then @jumping = false
            # @y = @y - floor(sqrt(sqrt(unit)))
        # if key[83] then @y = @y + floor(sqrt(sqrt(unit)))
        
        # World
        if @x < 0 then @x = 0
        if @y < 0 then @y = 0
        if @x + @w > canvas.width  then @x = canvas.width  - @w
        if @y + @h > canvas.height then @y = canvas.height - @h
        
    onFloor: (obj) ->
        unless obj then return false
        a = @contains(obj.x, obj.y)
        b = @contains(obj.x + obj.w, obj.y)
        c = obj.contains(@x, @y + @h) 
        d = obj.contains(@x + @w, @y + @h)
        
        m1 = M(a,b)
        m2 = M(c,d)
        
        return m1.elser(m2.elser(false))
        
    collide: (objects) ->
        hit = false
        for o in objects
            hit = @intersects(o)
            if hit
                @hit = o
                break
        return M(@hit).otherwise(false)
        # for obj in objects then hit = obj if obj.intersects(@)
        # return M(hit).otherwise(false)

window.Player = Player
