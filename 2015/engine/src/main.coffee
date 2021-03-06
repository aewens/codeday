require.config
    urlArgs: "nocache=" + (new Date).getTime()
        
require [
    "state",
    "gamestate",
    "menustate",
    "endstate",
    "winstate",
    "input",
    "canvas"
], (State, GameState, MenuState, EndState, WinState, InputHandler, Canvas) ->
    class Game
        constructor: ->
            @canvas = new Canvas 1080, 480
            
            @input = new InputHandler
                left:     65
                right:    68
                pulse:    74
                mana:     75
                spacebar: 32
                skip:     76
                heal:     73
                enter:    13
            
            @canvas.ctx.strokeStyle = "#fff"
            
            @States = 
                NO_CHANGE: 0
                MENU: 1
                GAME: 2
                END: 3
                WIN: 4
            
            @currentState = null
            @nextState = @States.MENU
            
            @ups = 1000/60
            @elapsed = 0
        run: ->
            self = @
            @canvas.animate (now) ->
                if self.nextState isnt self.States.NO_CHANGE
                    switch self.nextState
                        when self.States.MENU
                            self.currentState = new MenuState self
                        when self.States.GAME
                            self.currentState = new GameState self
                        when self.States.END
                            self.currentState = new EndState self
                        when self.States.WIN
                            self.currentState = new WinState self
                    self.nextState = self.States.NO_CHANGE
                
                self.currentState.handleInputs(self.input)
                
                self.last = now if !self.last
                self.elapsed = now - self.last
                if self.elapsed > self.ups
                    self.last = now
                    self.currentState.update()
                    
                self.currentState.render self.canvas.ctx

    game = new Game
    game.run()
