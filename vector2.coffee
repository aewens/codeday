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
        #@y flipped because <canvas>
        if M(v2).bool()
            sqrt(sqre(v2.x - @x) + sqre(@y - v2.y))
        else 
            sqrt(sqre(@prevX - @x) + sqre(@prevY - @y))
            
    dist: (v2) -> @distance(v2)
            
    changed: -> unless @x is @prevX or @y is @prevY then true else false
    
    diff2: (v2, invert) ->
        i = if invert then -1 else 1
        if M(v2).bool() then new Vector2((@x - v2.x) * i, (@y - v2.y) * i)
        else new Vector2((@x - @prevX) * i, (@y - @prevY) * i)
        
    diff: (v2) -> @diff2(v2, false)
        
window.Vector2 = Vector2
