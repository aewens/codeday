class Box
    constructor: (x, y, w, h, color) ->
        [@x, @y, @w, @h] = M(x, y, w, h).diverge([0,0,0,0])
        @color = M(color).otherwise({value: "#000"})
        
    move: (dx, dy) ->
        @x = @x + dx
        @y = @y + dy
        @
        
    collide: (obj) ->
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
        
        return [@hit, floor]
        
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
