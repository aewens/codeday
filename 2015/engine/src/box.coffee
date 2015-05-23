define ["pappai"], (Pappai) ->
    class Box
        constructor: (@x, @y, @w, @h) ->
        intersects: (s) ->
            offset = s.radius ? 0
            c0 = @contains s.x - offset, s.y - offset
            c1 = @contains s.x + s.width - offset, s.y - offset
            c2 = @contains s.x - offset, s.y + s.height - offset
            c3 = @contains s.x + s.width - offset, s.y + s.height - offset
            
            ca = @contains @x - offset, @y - offset
            cb = @contains @x + @w - offset, @y - offset
            cc = @contains @x - offset, @y + @h - offset
            cd = @contains @x + @w - offset, @y + @h - offset
            if c0 or c1 or c2 or c3
                return true
            else if ca or cb or cc or cd
                return true
            return false
        contains: (x, y) ->
            !!(x >= @x and x <= @x + @w and y >= @y and y <= @y + @h)
        has: (x, y) ->
            @contains(x, y)
        render: (color) ->
            color = color || false
            Pappai.Box(@w, @h).set(@x, @y).fg(color).render()
            
    return Box
