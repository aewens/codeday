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
            @game = (new Canvas 640, 480)
            @canvas = @game.canvas
            @ctx = @game.ctx
            
            mod = pow(2, 2)
            @ratio = [mod * 4, mod * 3]
            @unit  = @resize(@ratio[0], @ratio[1])
            
            @input = new InputHandler
                left:     65
                up:       87
                right:    68
                down:     83
                spacebar: 32
            
            @ctx.strokeStyle = "#fff"
            
            @currentState = null
            @nextState = States.GAME
            
            @ups = 1000/60
            @elapsed = 0
        resize: (r0, r1) ->
            w = parseInt window.innerWidth
            h = parseInt window.innerHeight
            r2 = r1/r0
            
            binr = (n) -> pow(2, floor(log(n)/log(2)))
            hone = (a, b, c, r) ->
                if a > c
                    if b > c*r then [c, c*r]
                    else hone(a, b, c * r, r)
                else hone(a, b, c * r, r)
            
            k = [
                (if r0 > r1 then w else h),
                (if r0 > r1 then h else w)
            ]
            q = binr(k[0])
            p = hone(k[0], k[1], q, r2)
            x = p[(if r0 > r1 then 0 else 1)]
            y = p[(if r0 > r1 then 1 else 0)]
            r = min(r0, r1)
            s = max(x, y)
            
            unit0 = binr(floor(s/r))
            unit1 = binr(floor(s/(r+1)))
            unit  = (unit0 + unit1) / 2
            
            @canvas.width  = unit * r0
            @canvas.height = unit * r1
            
            m0 = (h - @canvas.height) / 2
            m1 = (w - @canvas.width)  / 2
            
            @canvas.style.margin = "#{m0}px #{m1}px"
            
            unit
        run: ->
            self = @
            @game.animate (now) ->
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
                    
                self.currentState.render self.ctx

    game = new Game
    game.run()
