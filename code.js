// Generated by CoffeeScript 1.7.1
(function() {
  var Code, box1, box2, box3, code, move, v2;

  Code = (function() {
    function Code() {
      var canvas, ctext, cwords, wrapper;
      wrapper = document.querySelector("#wrapper");
      canvas = document.createElement("canvas");
      cwords = "Your browser is bad and you should feel bad";
      ctext = document.createTextNode(cwords);
      wrapper.appendChild(canvas).appendChild(ctext);
      canvas.width = window.innerWidth;
      canvas.height = window.innerHeight;
      window.addEventListener("resize", function(e) {
        canvas.width = window.innerWidth;
        return canvas.height = window.innerHeight;
      });
      this.canvas = canvas;
      this.ctx = this.canvas.getContext("2d");
    }

    Code.prototype.animate = function(cycle) {
      var l, rf, self;
      rf = function(x, y) {
        return window.requestAnimationFrame(x, y);
      };
      self = this;
      l = function() {
        cycle();
        return rf(l, self.canvas);
      };
      return rf(l, this.canvas);
    };

    return Code;

  })();

  code = new Code();

  box1 = new Box(100, 100, 100, 100);

  box2 = new Box(250, 100, 100, 100);

  box3 = new Box(400, 100, 100, 100);

  move = 1;

  v2 = new Vector2(1, 2);

  console.log(v2.set(3, 4));

  code.animate(function() {
    code.ctx.clearRect(0, 0, code.canvas.width, code.canvas.height);
    box2.move(move, 0);
    if (box2.intersects(box1) || box2.intersects(box3)) {
      move = -move;
      box2.move(move, 0);
    }
    box1.render(code.ctx, "#f00");
    box2.render(code.ctx, "#0f0");
    return box3.render(code.ctx, "#00f");
  });

  window.Code = Code;

}).call(this);
