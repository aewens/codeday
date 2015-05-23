define [
    "state", 
    "pappai",
    "player",
    "vector"
], (State, Pappai, Player, Vector) ->
    class GameState extends State
        constructor: (game) ->
            super game
            
            @w = @game.canvas.ctx.width
            @h = @game.canvas.ctx.height
            
            @player = new Player(100, 100, 40, "#f00", true)
            # @box = new Player(60, 60, 80, "#00f", false)
            @follow = new Player(0, 0, 40, "#ff0", true)
            @world = []
        handleInputs: (input) ->
            if input.x != null and input.y != null
                @follow.real.set(input.x, input.y)
                @follow.logic = new Vector(input.x, input.y)
        update: ->
            @world = [
                @player
            ]
            @follow.collide(@world)
        render: (ctx) ->
            ctx.clear()
            @follow.real.render()
            # @box.real.render()
            @player.real.render()
            @follow.real.link(@player.real)
    return GameState
