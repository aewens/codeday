// Generated by CoffeeScript 1.7.1
(function() {
  require.config({
    urlArgs: "nocache=" + (new Date).getTime()
  });

  require(["state", "gamestate", "input", "canvas"], function(State, GameState, InputHandler, Canvas) {
    var Game, States, game;
    States = {
      NO_CHANGE: 0,
      MENU: 1,
      GAME: 2,
      END: 3
    };
    Game = (function() {
      function Game() {
        this.canvas = new Canvas(1080, 480);
        this.input = new InputHandler({
          left: 65,
          right: 68,
          pulse: 74,
          spacebar: 32
        });
        this.canvas.ctx.strokeStyle = "#fff";
        this.currentState = null;
        this.nextState = States.GAME;
        this.ups = 1000 / 60;
        this.elapsed = 0;
      }

      Game.prototype.run = function() {
        var self;
        self = this;
        return this.canvas.animate(function(now) {
          if (self.nextState !== States.NO_CHANGE) {
            switch (self.nextState) {
              case States.MENU:
                self.currentState = new State(self);
                break;
              case States.GAME:
                self.currentState = new GameState(self);
                break;
              case States.END:
                self.currentState = new State(self);
            }
            self.nextState = States.NO_CHANGE;
          }
          self.currentState.handleInputs(self.input);
          if (!self.last) {
            self.last = now;
          }
          self.elapsed = now - self.last;
          if (self.elapsed > self.ups) {
            self.last = now;
            self.currentState.update();
          }
          return self.currentState.render(self.canvas.ctx);
        });
      };

      return Game;

    })();
    game = new Game;
    return game.run();
  });

}).call(this);
