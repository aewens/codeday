class Vector2
    constructor: (x, y) ->
        [@x, @y] = M(x, y).diverge([0, 0])
        [@prevX, @prevY] = [0, 0]
        @
    
    set: (x, y) ->
        [@prevX, @prevY] = [@x, @y]
        [@x, @y] = M(x, y).choose([x, y], [@x, @y])
        @
        
    normalize: -> 
        norm   = new Vector2(@x, @y)
        mag    = sqrt(sqre(norm.x) + sqre(norm.y)) # magnitude
        norm.x = norm.x / mag
        norm.y = norm.y / mag
        norm
        
    distance: (v2) ->
        if M(v2) != M.None
            sqrt(sqre(v2.x - @x) + sqre(@y - v2.y)) #@y flipped because <canvas>
        else 
            sqrt(sqre(@prevX - @x) + sqre(@prevY - @y))
            
    changed: -> unless @x is @prevX or @y is @prevY then true else false
    
    diff: (v2, invert) ->
        i = if invert then -1 else 1
        _v2 = M(v2).diverge(new Vector2((@x - @prevX) * i, (@y - @prevY) * i))
        return if v2 != _v2 then new Vector2((@x - v2.x) * i, (@y - v2.y) * i)
        
window.Vector2 = Vector2
