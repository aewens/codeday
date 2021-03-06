class Box
    constructor: (x, y, w, h, color, solid, win) ->
        [@x, @y, @w, @h] = M(x, y, w, h).diverge([0,0,0,0])
        @color = M(color).otherwise({value: "#000"})
        @solid = M(solid).otherwise(1)
        @win = M(win).otherwise(0)
        
    move: (dx, dy) ->
        @x = @x + dx
        @y = @y + dy
        @
        
    strike: (obj) ->
        a = @contains(obj.x, obj.y)
        b = @contains(obj.x + obj.w, obj.y)
        c = @contains(obj.x, obj.y + obj.h)
        d = @contains(obj.x + obj.w, obj.y + obj.h)
        m1 = M(a,b,c,d)
        
        m = obj.contains(@x, @y)
        n = obj.contains(@x + @w, @y)
        o = obj.contains(@x, @y + @h) 
        p = obj.contains(@x + @w, @y + @h)
        m2 = M(m,n,o,p)
        
        @hit = m1.elser(m2.elser(false))
        return @hit
        
    inside: (obj) ->
        offset = M(obj.radius).otherwise(0)
        a = @contains(obj.x - offset, obj.y - offset)
        b = @contains(obj.x + obj.w - offset, obj.y - offset)
        c = @contains(obj.x - offset, obj.y + obj.h - offset)
        d = @contains(obj.x + obj.w - offset, obj.y + obj.h - offset)
        m1 = M(a,b,c,d)
        
        # m = obj.contains(@x - offset, @y - offset)
        # n = obj.contains(@x + @w - offset, @y - offset)
        # o = obj.contains(@x - offset, @y + @h - offset) 
        # p = obj.contains(@x + @w - offset, @y + @h - offset)
        # m2 = M(m,n,o,p)
        
        @hit = m1.elser(false)
        return @hit
        
    # inside: (obj) ->
    #     offset = M(obj.radius).otherwise(0)
    #     a = @contains(obj.x - offset, obj.y - offset)
    #     b = @contains(obj.x + obj.w - offset, obj.y - offset)
    #     c = @contains(obj.x - offset, obj.y + obj.h - offset)
    #     d = @contains(obj.x + obj.w - offset, obj.y + obj.h - offset)
    #     m1 = M(a,b,c,d)
    #     
    #     @hit = m1.elser(false)
    #     
    #     return @hit
        
    collide: (obj) ->
        ignore = false
        if obj.solid is 0 then ignore = true
        a = @contains(obj.x, obj.y)
        b = @contains(obj.x + obj.w, obj.y)
        c = @contains(obj.x, obj.y + obj.h)
        d = @contains(obj.x + obj.w, obj.y + obj.h)
        m1 = M(a,b,c,d)
        
        m = obj.contains(@x, @y)
        n = obj.contains(@x + @w, @y)
        o = obj.contains(@x, @y + @h) 
        p = obj.contains(@x + @w, @y + @h)
        m2 = M(m,n,o,p)
        
        m3 = M(a,b,o,p)
        
        
        @hit = m1.elser(m2.elser(false))
        floor = m3.elser(false)
        
        return [ignore, @hit, floor]
        
    contains: (x, y) ->
        if x >= @x and x <= @x + @w and y >= @y and y <= @y + @h
            true
        else
            false
            
    update: (unit, canvas) ->
    
    render: (ctx) ->
        ctx.fillStyle = @color.value
        ctx.fillRect(@x, @y, @w, @h)
         
window.Box = Box
