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
        fill: (x, y, type) ->
            return null if type is "void"
            block = new Block(x * @size, y * @size, @size, "#000")
            block.real.give("type", type)
            block
        locate: (key, type) ->
            @blocks[key] = @fill(key%@width, key//@w, type)
        select: (x, y, type) ->
            @blocks[x+y*@w] = @fill(x, y, type)
        row: (r, type) ->
            for x in [0...@w]
                @blocks[x+r*@w] = @fill(x, r, type)
        col: (c, type) ->
            for y in [0...@h]
                @blocks[c+y*@w] = @fill(c, y, type)
        fromR: (x, y, to, type) ->
            for i in [0...to]
                @blocks[(x+i)+y*@w] = @fill(x+i, y, type)
        fromD: (x, y, to, type) ->
            for i in [0...to]
                @blocks[x+(y+i)*@w] = @fill(x, y+i, type)
        getAll: ->
            @blocks.filter (x) -> x != null
        update: ->
            @world = @getAll()
        render: ->
            blocks = @getAll()
            blocks[i].real.render() for i in [0...blocks.length]
                
    return Map
