define [
    "state",
    "pappai"
], (State, Pappai) ->
    class WinState extends State
        constructor: (@game) ->
            super game
            
            @w = @game.canvas.ctx.width
            @h = @game.canvas.ctx.height
            
            @title = Pappai.Text(50).set(300, 128)
            @enter = Pappai.Text(16).set(440, 256)
            @menu = Pappai.Text(16).set(435, 300)
        handleInputs: (input) ->
            if input.isPressed("enter")
                @game.nextState = @game.States.GAME
            if input.isPressed("spacebar")
                @game.nextState = @game.States.MENU
        update: ->
        render: (ctx) ->
            ctx.clear()
            @title.render("You win! Hurray!")
            @enter.render("( press enter to enter )")
            @menu.render("( press space to menu )")
    return WinState
