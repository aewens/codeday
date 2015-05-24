define [
    "block"
], (Block) ->
    class Map
        constructor: (@w, @h, @size) ->
            @world = []
            @blocks = []
            @objects = []
            @length = @w * @h
            for i in [0...@length]
                @blocks.push null
            @
        use: (object) ->
            @objects.push object
        fill: (x, y) ->
            color = "#" + floor(random() * 999)
            block = new Block(x * @size, y * @size, @size, color)
            block.real.give("type", "block")
            block
        locate: (key, block) ->
            @blocks[key] = if block then @fill(key%@width,key//@w) else null
        select: (x, y, block) ->
            @blocks[x+y*@w] = if block then @fill(x, y) else null
        row: (r, block) ->
            for x in [0...@w]
                @blocks[x+r*@w] = if block then @fill(x, r) else null
        col: (c, block) ->
            for y in [0...@h]
                @blocks[c+y*@w] = if block then @fill(c, y) else null
        fromR: (x, y, to, block) ->
            for i in [0...to]
                @blocks[(x+i)+y*@w] = if block then @fill(x+i, y) else null
        fromD: (x, y, to, block) ->
            for i in [0...to]
                @blocks[x+(y+i)*@w] = if block then @fill(x, y+i) else null
        getAll: ->
            @blocks.filter (x) -> x != null
        update: ->
            blocks = @getAll()
            @world = @objects.concat(blocks)
        render: ->
            blocks = @getAll()
            blocks[i].real.render() for i in [0...blocks.length]
                
    return Map
