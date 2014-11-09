class Box
    constructor: (x, y, w, h, color) ->
        [@x, @y, @w, @h] = M(x, y, w, h).diverge([0,0,0,0])
        @color = M(color).otherwise({value: "#000"})
        
    # intersects: (shape) ->
    #     offset = M(shape.radius).otherwise(0)
    #     a = @contains(shape.x - offset, shape.y - offset)
    #     b = @contains(shape.x + shape.w - offset, shape.y - offset)
    #     c = @contains(shape.x - offset, shape.y + shape.h - offset)
    #     d = @contains(shape.x + shape.w - offset, shape.y + shape.h - offset)
    #     m1 = M(a,b,c,d)
    #     
    #     m = shape.contains(@x - offset, @y - offset)
    #     n = shape.contains(@x + @w - offset, @y - offset)
    #     o = shape.contains(@x, @y - offset + @h - offset) 
    #     p = shape.contains(@x + @w - offset, @y + @h - offset)
    #     m2 = M(m,n,o,p)
    #     
    #     @hit = m1.elser(m2.elser(false))
    #     
    #     return @hit
    
    intersects: (obj) ->
        a = @contains(obj.x, obj.y)
        b = @contains(obj.x + obj.w, obj.y)
        c = @contains(obj.x, obj.y + obj.h)
        d = @contains(obj.x + obj.w, obj.y + obj.h)
        m = obj.contains(@x, @y)
        n = obj.contains(@x + @w, @y)
        o = obj.contains(@x, @y + @h)
        p = obj.contains(@x + @w, @y + @h)
        
        w = M(a,c)
        x = M(b,d)
        y = M(m,o)
        z = M(n,p)
        
        @hit = w.elser(x.elser(y.elser(z.elser(false))))
        return @hit
        
    move: (dx, dy) ->
        @x = @x + dx
        @y = @y + dy
        @
        
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
