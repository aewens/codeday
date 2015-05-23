define [
    "state", 
    "polygon"
], (State, Polygon) ->
    class GameState extends State
        constructor: (game) ->
            super game
            
            @w = @game.canvas.ctx.width
            @h = @game.canvas.ctx.height
        handleInputs: (input) ->
        update: ->
        render: (ctx) ->
            ctx.clear()

    return GameState
