// Generated by CoffeeScript 1.7.1
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(["state", "pappai"], function(State, Pappai) {
    var EndState;
    EndState = (function(_super) {
      __extends(EndState, _super);

      function EndState(game) {
        this.game = game;
        EndState.__super__.constructor.call(this, game);
        this.w = this.game.canvas.ctx.width;
        this.h = this.game.canvas.ctx.height;
        this.step = 0;
        this.title = Pappai.Text(50).set(300, 128);
        this.enter = Pappai.Text(16).set(440, 256);
        this.menu = Pappai.Text(16).set(435, 300);
      }

      EndState.prototype.handleInputs = function(input) {
        if (input.isPressed("enter")) {
          this.game.nextState = this.game.States.GAME;
        }
        if (input.isPressed("spacebar")) {
          return this.game.nextState = this.game.States.MENU;
        }
      };

      EndState.prototype.update = function() {};

      EndState.prototype.render = function(ctx) {
        ctx.clear();
        switch (this.step) {
          case 0:
            this.title.render("You died. Ooops.");
            this.enter.render("( press enter to enter )");
            return this.menu.render("( press space to menu )");
          case 1:
            return console.log(0);
        }
      };

      return EndState;

    })(State);
    return EndState;
  });

}).call(this);
