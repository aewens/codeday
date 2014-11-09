// Generated by CoffeeScript 1.7.1
(function() {
  var Code, code, darkness, level, light, mob1, physics, player, render, sy, update;

  Code = (function() {
    function Code() {
      var canvas, ctext, cwords, self, wrapper;
      wrapper = document.querySelector("#wrapper");
      canvas = document.createElement("canvas");
      cwords = "Your browser is bad and you should feel bad";
      ctext = document.createTextNode(cwords);
      wrapper.appendChild(canvas).appendChild(ctext);
      this.canvas = canvas;
      this.ctx = this.canvas.getContext("2d");
      this.dimensions(wrapper);
      self = this;
      window.addEventListener("resize", function(e) {
        return self.dimensions(wrapper);
      });
    }

    Code.prototype.dimensions = function(root) {
      var h, m0, m1, r0, r1, r2, w, x, y;
      w = root.offsetWidth;
      h = root.offsetHeight;
      r0 = 16;
      r1 = 9;
      r2 = r0 * r1;
      x = min(w, h);
      y = min(r0, r1);
      this.unit = pow(2, floor(log(floor(x / y)) / log(2)));
      this.canvas.width = this.unit * r0;
      this.canvas.height = this.unit * r1;
      m0 = (h - this.canvas.height) / 2;
      m1 = (w - this.canvas.width) / 2;
      return this.canvas.style.margin = "" + m0 + "px " + m1 + "px";
    };

    Code.prototype.inputs = function() {
      var self;
      this.keyState = {};
      self = this;
      document.addEventListener("keydown", function(e) {
        return self.keyState[e.keyCode] = true;
      });
      return document.addEventListener("keyup", function(e) {
        return self.keyState[e.keyCode] = false;
      });
    };

    Code.prototype.animate = function(update, render) {
      var l, rf, self;
      self = this;
      rf = function(x, y) {
        return window.requestAnimationFrame(x, y);
      };
      l = function() {
        update();
        render();
        return rf(l, self.canvas);
      };
      return rf(l, this.canvas);
    };

    return Code;

  })();

  code = new Code();

  code.inputs();

  sy = code.canvas.height - code.unit * 2;

  level = new Level(TestLevel, code.unit);

  darkness = new Box(0, 0, code.canvas.width, code.canvas.height, new Color(0, 0, 0, 0.5));

  mob1 = new Mob(code.unit * 0.5, sy);

  player = new Player(code.unit * 2, sy);

  light = new Light(player, code.unit);

  physics = new Physics(code, level, player, darkness, light);

  physics.addMobs(mob1);

  console.log(player);

  console.log(light);

  update = function() {
    return physics.update();
  };

  render = function() {
    return physics.render();
  };

  code.animate(update, render);

  window.Code = Code;

}).call(this);
