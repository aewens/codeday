// Generated by CoffeeScript 1.7.1
(function() {
  var End;

  End = (function() {
    function End(root, canvas, ctx) {
      this.root = root;
      this.canvas = canvas;
      this.ctx = ctx;
      this.once = false;
      this.reset = false;
    }

    End.prototype.update = function() {
      var endDiv, endText;
      if (!this.once) {
        endDiv = document.createElement("div");
        endDiv.id = "end";
        endText = document.createTextNode("Game Over");
        this.root.appendChild(endDiv).appendChild(endText);
        this.once = true;
        return document.addEventListener("click", function(e) {
          return window.location.reload(true);
        });
      }
    };

    End.prototype.render = function() {
      this.ctx.fillStyle = "#000";
      return this.ctx.fillRect(0, 0, this.canvas.width, this.canvas.height);
    };

    return End;

  })();

  window.End = End;

}).call(this);
