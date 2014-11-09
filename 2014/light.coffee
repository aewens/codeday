class Light
    constructor: (player) ->
        @you = player
        [@h,@s,@l,@a] = [0, 0, 100, 0.2]
        @color = new Color(@h,@s,@l,@a)
        @radius = @you.w * 1.5
        @w = @you.w 
        @h = @you.h
        @x = @you.x
        @y = @you.y
        
    brightness: (delta) -> @color = new Color(@h,@s,@l,@a + delta)
    ligthen: -> @brightness(0.1)
    darken: -> @brightness(-0.1)
    grow: -> @radius + 1
    shrink: -> @radius - 1
    update: (x, y) ->
        @x = x + (@w / 2)
        @y = y + (@h / 2)
    render: (ctx) ->
        ctx.fillStyle = @color.value
        ctx.beginPath()
        ctx.arc(@x, @y, @radius, 0, 2 * pi)
        ctx.fill()
        ctx.closePath()
    
window.Light = Light
