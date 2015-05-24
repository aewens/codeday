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
            @canvas = new Canvas 1080, 480
            
            @input = new InputHandler
                left:     65
                right:    68
                pulse:    74
                spacebar: 32
                # up:       87
            
            @canvas.ctx.strokeStyle = "#fff"
            
            @currentState = null
            @nextState = States.GAME
            
            @ups = 1000/60
            @elapsed = 0
        run: ->
            self = @
            @canvas.animate (now) ->
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
                
                self.last = now if !self.last
                self.elapsed = now - self.last
                if self.elapsed > self.ups
                    self.last = now
                    self.currentState.update()
                    
                self.currentState.render self.canvas.ctx

    game = new Game
    game.run()
