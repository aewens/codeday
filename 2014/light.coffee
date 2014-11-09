class Light
    constructor: (player) ->
        @you = player
        [@h,@s,@l,@a] = [0, 0, 100, 0.6]
        @color = new Color(@h,@s,@l,@a)
        @radius = @you.w * 2
        @w = @you.w / 2
        @h = @you.h / 2
        @x = @you.x + @w
        @y = @you.y + @h
        
    brightness: (delta) -> @color = new Color(@h,@s,@l,@a + delta)
    ligthen: -> @brightness(0.1)
    darken: -> @brightness(-0.1)
    grow: -> @radius = @radius + 1
    shrink: -> @radius = @radius - 1 if @radius >= 0
    update: (x, y) ->
        @x = x + @w
        @y = y + @h
    inside: (obj) ->
        offset = M(@radius).otherwise(0)
        a = obj.contains(@x + offset, @y)
        b = obj.contains(@x - offset, @y - offset)
        c = obj.contains(@x, @y + offset) 
        d = obj.contains(@x, @y - offset)
        
        @hit = M(a,b,c,d).elser(false)
        return @hit
    render: (ctx) ->
        ctx.fillStyle = @color.value
        ctx.beginPath()
        ctx.arc(@x, @y, @radius, 0, 2 * pi)
        ctx.fill()
        ctx.closePath()
    
window.Light = Light
