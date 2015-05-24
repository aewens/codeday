define [
    "map"
], (Map) ->
    # Spawn
    # Level 1
    Levels = [ 
        [
            ["row", 11, "platform"],
            ["fromR", 4, 7, 5, "platform"],
            # ["fromR", 16, 4, 5, "platform"]
        ],
        [
            ["row", 11, "platform"],
            ["fromR", 4, 7, 5, "platform"],
            ["fromR", 16, 4, 5, "platform"]
        ],
        [
            ["row", 11, "platform"],
            ["fromR", 4, 7, 5, "platform"],
            ["fromR", 16, 4, 5, "platform"]
        ],
        [
            ["row", 11, "platform"],
            ["fromR", 4, 7, 5, "platform"],
            ["fromR", 16, 4, 5, "platform"]
        ],
        [
            ["row", 11, "platform"],
            ["fromR", 4, 7, 5, "platform"],
            ["fromR", 16, 4, 5, "platform"]
        ]
    ]
    class Level
        constructor: (@w, @h, @size) ->
            @map = new Map(@w, @h, @size)
            @max = Levels.length
            @current = 0
            @mana = 1000
            @mreset = 1000
        start: ->
            @select(@current)
        select: (lvl) ->
            @current = lvl
            level = Levels[lvl]
            for order in level
                cmd = order[0]
                params = order.slice(1)
                @map[cmd].apply(@map, params)
            @map
        next: ->
            @map = new Map(@w, @h, @size)
            @current = (@current + 1) #% Levels.length
            @select(@current)
    return Level
