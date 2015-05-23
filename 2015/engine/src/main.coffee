require.config
    urlArgs: "nocache=" + (new Date).getTime()
        
require [
    "state",
    "gamestate",
    "input",
    "canvas"
], (State, GameState, InputHandler, Canvas) ->
    States = 
        NO_CHANGE: 0
        MENU: 1
        GAME: 2
        END: 3

    class Game
        constructor: ->
            @canvas = new Canvas 640, 480
            
            @input = new InputHandler
                left:     65
                up:       87
                right:    68
                down:     83
                spacebar: 32
            
            @canvas.ctx.strokeStyle = "#fff"
            
            @currentState = null
            @nextState = States.GAME
        run: ->
            self = @
            @canvas.animate ->
                if self.nextState isnt States.NO_CHANGE
                    switch self.nextState
                        when States.MENU
                            self.currentState = new State self
                        when States.GAME
                            self.currentState = new GameState self
                        when States.END
                            self.currentState = new State self
                    self.nextState = States.NO_CHANGE
                    
                self.currentState.handleInputs(self.input)
                self.currentState.update()
                self.currentState.render self.canvas.ctx

    game = new Game
    game.run()
