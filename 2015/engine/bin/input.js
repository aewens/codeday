// Generated by CoffeeScript 1.7.1
(function() {
  define(function() {
    var InputHandler;
    InputHandler = (function() {
      function InputHandler(keys) {
        var code, key, self;
        this.keys = keys;
        this.down = {};
        this.pressed = {};
        for (key in this.keys) {
          code = this.keys[key];
          this.keys[code] = key;
          this.down[key] = false;
          this.pressed[key] = false;
        }
        self = this;
        document.addEventListener("keydown", function(e) {
          var keyCode;
          keyCode = self.keys[e.keyCode];
          if (keyCode) {
            return self.down[keyCode] = true;
          }
        });
        document.addEventListener("keyup", function(e) {
          var keyCode;
          keyCode = self.keys[e.keyCode];
          if (keyCode) {
            self.down[keyCode] = false;
            return self.pressed[keyCode] = false;
          }
        });
      }

      InputHandler.prototype.isDown = function(key) {
        return this.down[key];
      };

      InputHandler.prototype.isPressed = function(key) {
        if (this.pressed[key]) {
          return false;
        } else if (this.down[key]) {
          return this.pressed[key] = true;
        }
        return false;
      };

      return InputHandler;

    })();
    return InputHandler;
  });

}).call(this);
