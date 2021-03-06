define [
    "state",
    "pappai"
], (State, Pappai) ->
    class MenuState extends State
        constructor: (@game) ->
            super game
            
            @w = @game.canvas.ctx.width
            @h = @game.canvas.ctx.height
            
            @title = Pappai.Text(50).set(325, 128)
            @enter = Pappai.Text(16).set(440, 256)
        handleInputs: (input) ->
            if input.isPressed("enter")
                @game.nextState = @game.States.GAME
        update: ->
        render: (ctx) ->
            ctx.clear()
            @title.render("The Reckoning")
            @enter.render("( press enter to enter )")
    return MenuState
