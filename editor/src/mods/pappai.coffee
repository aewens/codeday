# Paper & Paint
# Depends on dom.coffee
define ["mods/dom"], ($) ->
    class CNode
        constructor: ->
            @PAPER = $.find("canvas").element
            @PAINT = @PAPER.getContext("2d")
            @x = 0
            @y = 0
            @fcolor = "#000"
            @bcolor = "#fff"
            @scolor = "#000"
        set: (x, y) ->
            @x = x
            @y = y
            @
        fg: (color) ->
            @fcolor = color || @fcolor
            @
        bg: (color) ->
            @bcolor = color || @bcolor
            @
        sg: (color) ->
            @scolor = color || @scolor
            @
        give: (k, v) ->
            @[k] = v
            @
        get: (k) -> @[k]
        line: (xa, ya, xb, yb) ->
            @PAINT.beginPath()
            @PAINT.moveTo(xa, ya)
            @PAINT.lineTo(xb, yb)
            @PAINT.closePath()
            @PAINT.strokeStyle = @scolor
            @PAINT.stroke()
        link: (node) ->
            @line(@x, @y, node.x, node.y) if node instanceof CNode
            @
    
    class CCircle extends CNode
        constructor: (Pappai, radius) ->
            @give("radius", radius)
            @give("pi", Math.PI)
            @give("tau", 2 * Math.PI)
            super
        render: ->
            @PAPER.style.backgroundColor = @bcolor
            @PAINT.fillStyle = @fcolor
            @PAINT.arc(@x, @y, @radius, 0, @tau)
            @PAINT.fill()
            @
            
    class CBox extends CNode
        constructor: (Pappai, width, height) ->
            @give("width", width)
            @give("height", height)
            super
        render: ->
            @PAPER.style.backgroundColor = @bcolor
            @PAINT.fillStyle = @fcolor
            @PAINT.rect(@x, @y, @width, @height)
            @PAINT.fill()
            @
            
    class CSquare extends CNode
        constructor: (Pappai, side) ->
            @give("side", side)
            super
        render: ->
            @PAPER.style.backgroundColor = @bcolor
            @PAINT.fillStyle = @fcolor
            @PAINT.rect(@x, @y, @side, @side)
            @PAINT.fill()
            @
    
    Pappai =
        Node: -> new CNode()
        Circle: (radius) -> new CCircle(@, radius)
        Box: (width, height) -> new CBox(@, width, height)
        Square: (side) -> new CSquare(@, side)
            
    return Pappai
