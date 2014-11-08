class Box
    constructor: (x, y, w, h) ->
        [@x, @y, @w, @h] = M(x, y, w, h).diverge([0,0,0,0])
        
    intersects: (shape) ->
        offset = M(shape.radius).otherwise(0)
        m1 = M(
            @contains(shape.x - offset, shape.y - offset), 
            @contains(shape.x + shape.w - offset, shape.y - offset), 
            @contains(shape.x - offset, shape.y + shape.h - offset), 
            @contains(shape.x + shape.w - offset, shape.y + shape.h - offset))
        m2 = M(
            shape.contains(@x - offset, @y - offset), 
            shape.contains(@x + @w - offset, @y - offset), 
            shape.contains(@x, @y - offset + @h - offset), 
            shape.contains(@x + @w - offset, @y + @h - offset))
            
        m1.elser(m2.elser(false))
        
    move: (dx, dy) ->
        @x = @x + dx
        @y = @y + dy
        @
        
    contains: (x, y) ->
        if x >= @x and x <= @x + @w and y >= @y and y <= @y + @h
            true
        else
            false
    
    render: (ctx, colors...) ->
        switch colors.length
            when 1 then color = colors[0]
            when 3 then color = "hsl(#{colors[0]},#{colors[1]},#{colors[2]})"
            when 4
                color = "hsla(#{colors[0]},#{colors[1]},
                        #{colors[2]},#{colors[3]})"
            else color = "#fff"
            
        ctx.fillStyle = color
        ctx.fillRect(@x, @y, @w, @h)
         
window.Box = Box
