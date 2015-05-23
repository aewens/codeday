define [
    "pappai",
    "vector"
], (Pappai, Vector) ->
    class Player
        constructor: (@x, @y, @r, @color) ->
            @Reecelet = Pappai.Circle(@r).fg(@color).set(@x, @y)
            @Ewensian = new Vector(@x, @y)
        collide: (ox, oy, x, y) ->
            p = @points
            c = false
            j = p.length - 2
            for i in [0...p.length] by 2
                px1 = p[i] + ox
                px2 = p[j] + ox
                py1 = p[i+1] + oy
                py2 = p[j+1] + oy
                
                cond1 = (py1 > y) != (py2 > y)
                cond2 = x < (px2-px1) * (y-py1) / (py2-py1) + px1
                c = !c if cond1 and cond2
                j = i
            c

    return Player
