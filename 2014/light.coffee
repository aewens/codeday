class Light
    constructor: (player,unit) ->
        @you = player
        @unit = unit
        [@h,@s,@l,@a] = [0, 0, 100, 0.2]
        @color = new Color(@h,@s,@l,@a)
        @radius = @you.w * 1.5
        @center = [@you.x+(@you.w/2),(@you.y+(@you.h/2)-(@unit/4))]
        
    brightness: (delta) -> @color = new Color(@h,@s,@l,@a + delta)
    ligthen: -> @brightness(0.1)
    darken: -> @brightness(-0.1)
    grow: -> @radius + 1
    shrink: -> @radius - 1
    update: (player) ->
        @you = player
        @center = [@you.x+(@you.w/2),(@you.y+(@you.h/2)-(@unit/4))]
    render: (ctx) ->
        ctx.fillStyle = @color.value
        ctx.beginPath()
        ctx.arc(@center[0], @center[1], @radius, 0, 2 * pi)
        ctx.fill()
        ctx.closePath()
    
window.Light = Light
