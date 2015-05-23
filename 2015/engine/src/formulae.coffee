define ["pappai"], (Pappai) ->
    class Formulae
        constructor: (@fnx, @fny, @steps) ->
            @nodes = []
            @scale = 0
            @angle = 0
            @shift =
                x: 0
                y: 0
            @
        grow: (@scale) -> @
        move: (x, y) ->
            @shift.x = x
            @shift.y = y
            @
        rotate: (inc) ->
            @angle = @angle + inc
        set: (@x, @y) -> @
        cache: (@nodes) -> @
        render: (ctx, opts) -> # Black Magic™
            prev =
                x: @x ? 0
                y: @y ? 0
            ctx.beginPath()
            opts = opts || {}
            if @nodes and @nodes.length is 0
                nodes = []
                for i in [0..@steps]
                    x = @fnx i, prev.x
                    y = @fny i, prev.y
                    prev.x = x
                    prev.y = y
                    x = x * @scale
                    y = y * @scale
                    
                    xz = x * cos(@angle) - y * sin(@angle)
                    yz = x * sin(@angle) + y * cos(@angle)
                    
                    xx = xz + @shift.x
                    yx = yz + @shift.y
                    if i is 0
                        ctx.moveTo xx, yy
                    else
                        ctx.lineTo xx, yy
                    nodes.push x
                    nodes.push y
                @cache nodes
            else
                for i in [0...@nodes.length] by 2
                    xz = @nodes[i] * cos(@angle) - @nodes[i+1] * sin(@angle)
                    yz = @nodes[i] * sin(@angle) + @nodes[i+1] * cos(@angle)
                    xx = xz + @shift.x
                    yy = yz + @shift.y
                    if i is 0
                        ctx.moveTo xx, yy
                    else
                        ctx.lineTo xx, yy
            ctx.closePath()
            ctx.lineWidth = opts.size ? 1
            ctx.fillStyle = opts.fcolor ? "#f00"
            ctx.strokeStyle = opts.scolor ? "#00f"
            ctx.stroke() if opts.doStroke
            ctx.fill() unless opts.noFill
            nodes
        
    return Formulae

# Formulae is a recursive system of feeding in an amount of steps and starting 
# x and y passed into their respective function until the steps are completed

# Formulae uses a subset of Pappai's CNode functionality to quickly access
# control of the canvas in a user-friendly manner using Black Magic™

# Example:
# fnx = (i) ->
#   i *= 5 * tau / @steps
#   cos(i) * @scale + @shift.x
# fny = (i) ->
#   i *= 5 * tau / 7
#   sin(i) * @scale + @shift.y
# 
# new Formulae(fnx,fny,7).grow(50).move(w/2,h/2).set(0,0).render()

# This will render a seven point star scaled by 50 in the middle of the screen
