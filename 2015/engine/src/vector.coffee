define ->
    class Vector
        constructor: (@x, @y) ->
        use: -> [@x, @y]
        inc: (s) ->
            new Vector(@x + s, @y + s)
        dec: (s) ->
            new Vector(@x - s, @y - s)
        scale: (s) ->
            new Vector(@x * s, @y * s)
        shrink: (s) ->
            new Vector(@x / s, @y / s)
        add: (v) ->
            new Vector(@x + v.x, @y + v.y)
        add2: (x, y) ->
            v = new Vector(x, y)
            @add(v)
        sub: (v) ->
            new Vector(@x - v.x, @y - v.y)
        sub2: (x, y) ->
            v = new Vector(x, y)
            @sub(v)
        norm: ->
            new Vector(@x / @mag(), @y / @mag())
        mag: ->
            sqrt(sqre(@x) + sqre(@y))
        mag2: ->
            @x * @x + @y * @y
        dot: (v) ->
            @x * v.x + @y * v.y
        dot2: (u, v) ->
            u.x * v.x + u.y * v.y
        theta: (v) ->
            acos(@dot2(@norm(), v.norm()))

    return Vector
