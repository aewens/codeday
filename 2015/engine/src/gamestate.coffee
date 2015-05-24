define [
    "state", 
    "pappai",
    "vector",
    "player",
    "block",
    "map"
], (State, Pappai, Vector, Player, Block, Map) ->
    class GameState extends State
        constructor: (game) ->
            super game
            
            @w = @game.ctx.width
            @h = @game.ctx.height
            
            @player = new Player(60, @h - 200, 20, "#00f")
            
            @map = new Map(16, 12, 40)
            @map.row(11, "platform")
            @map.fromR(4, 7, 5, "platform")
        handleInputs: (input) ->
            # if input.x != null and input.y != null
            #     @player.real.set(input.x, input.y)
            #     @player.logic = new Vector(input.x, input.y)
            if input.isDown("left")
                @player.move(-1, 0)
            if input.isDown("right")
                @player.move(1, 0)
            if input.isPressed "spacebar"
                @player.move(0, -40) if @player.canJump
        update: ->
            @map.update(@player)
            @player.update(@map)
        render: (ctx) ->
            ctx.clear()
            @player.render()
            @map.render()
    return GameState
