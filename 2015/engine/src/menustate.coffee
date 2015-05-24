define [
    "state",
    "pappai"
], (State, Pappai) ->
    class MenuState extends State
        constructor: (@game) ->
            super game
            
            @w = @game.canvas.ctx.width
            @h = @game.canvas.ctx.height
            
            @step = 0
            
            @title = Pappai.Text(50).set(325, 128)
            @enter = Pappai.Text(16).set(440, 256)
        handleInputs: (input) ->
            if input.isPressed("enter")
                # @step = 1
                @game.nextState = @game.States.GAME
        update: ->
        render: (ctx) ->
            ctx.clear()
            switch @step
                when 0
                    @title.render("The Reckoning")
                    @enter.render("( press enter to enter )")
                when 1
                    console.log 0
    return MenuState
