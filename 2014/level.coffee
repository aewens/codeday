class Level
    constructor: (level, unit) ->
        one = level.points
        @types = level.types
        @solid = level.solid
        @win = level.win
        @three = [[]]
        @unit = unit
        @w = one[0]
        @h = one[1]
        @one = @points = one.slice(2)
        # For the lazy
        # ps = []
        # for p in [0..o.length-1]
        #     [y, x] = [floor(p/@w),(p%@w)]
        #     @three[y] = M(@three[y]).otherwise([])
        #     @three[y][x] = o[p]
        # @lazy = @three
        @blocks = []
        self = @
        for o in [0..@one.length-1]
            color = @types[@one[o]+1]
            solid = @solid[@one[o]+1]
            win = @win[@one[o]+1]
            if color is null then continue
            [x, y] = @xy(o).map (i) -> i * self.unit
            @blocks.push new Box(x, y, @unit, @unit, color, solid, win)
    point: (x, y) -> @one[x+y*@h]
    xy: (p) -> [(p%@w),floor(p/@w)]
    render: (ctx) ->
        for block in @blocks then block.render(ctx)
            
    
window.Level = Level
