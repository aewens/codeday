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
            # 640 : 2,4,5,8,10,16,20,32,40,64,80,128,160,320,640
            #       2,2,2,2,2,2,2,5
            # 480 : 2,3,4,5,6,8,10,12,15,16,20,24,30,32,40,48,60,80,96,120,160,240,480
            #       2,2,2,2,2,3,5
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
