// Generated by CoffeeScript 1.7.1
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(function() {
    var CBox, CCircle, CNode, CSquare, CText, Pappai;
    CNode = (function() {
      function CNode() {
        this.PAPER = document.getElementById("pappai");
        this.PAINT = this.PAPER.getContext("2d");
        this.x = 0;
        this.y = 0;
        this.xx = 0;
        this.yy = 0;
        this.fcolor = "#000";
        this.bcolor = "#fff";
        this.scolor = "#000";
      }

      CNode.prototype.give = function(k, v) {
        this[k] = v;
        return this;
      };

      CNode.prototype.flag = function(opts) {
        var k, v;
        for (k in opts) {
          v = opts[k];
          this[k] = v;
        }
        return this;
      };

      CNode.prototype.get = function(k) {
        return this[k];
      };

      CNode.prototype.mid = function(x, y) {
        return [x, y];
      };

      CNode.prototype.set = function(x, y) {
        var xy;
        this.x = x;
        this.y = y;
        xy = this.mid(x, y);
        this.xx = xy[0];
        this.yy = xy[1];
        return this;
      };

      CNode.prototype.fg = function(color) {
        this.fcolor = color || this.fcolor;
        return this;
      };

      CNode.prototype.bg = function(color) {
        this.bcolor = color || this.bcolor;
        return this;
      };

      CNode.prototype.sg = function(color) {
        this.scolor = color || this.scolor;
        return this;
      };

      CNode.prototype.line = function(xa, ya, xb, yb) {
        var _ref;
        this.PAINT.beginPath();
        this.PAINT.moveTo(xa, ya);
        this.PAINT.lineTo(xb, yb);
        this.PAINT.closePath();
        this.PAINT.lineWidth = (_ref = this.size) != null ? _ref : 1;
        this.PAINT.strokeStyle = this.scolor;
        return this.PAINT.stroke();
      };

      CNode.prototype.link = function(node) {
        if (node instanceof CNode) {
          this.line(this.xx, this.yy, node.xx, node.yy);
        }
        return this;
      };

      return CNode;

    })();
    CCircle = (function(_super) {
      __extends(CCircle, _super);

      function CCircle(Pappai, radius) {
        this.give("radius", radius);
        this.give("pi", Math.PI);
        this.give("tau", 2 * Math.PI);
        CCircle.__super__.constructor.apply(this, arguments);
      }

      CCircle.prototype.render = function() {
        var _ref;
        this.PAPER.style.backgroundColor = this.bcolor;
        this.PAINT.fillStyle = this.fcolor;
        this.PAINT.strokeStyle = this.scolor;
        this.PAINT.lineWidth = (_ref = this.size) != null ? _ref : 1;
        this.PAINT.beginPath();
        this.PAINT.arc(this.x, this.y, this.radius, 0, this.tau);
        this.PAINT.closePath();
        if (!this.noFill) {
          this.PAINT.fill();
        }
        if (this.doStroke) {
          this.PAINT.stroke();
        }
        return this;
      };

      return CCircle;

    })(CNode);
    CBox = (function(_super) {
      __extends(CBox, _super);

      function CBox(Pappai, width, height) {
        this.give("width", width);
        this.give("height", height);
        CBox.__super__.constructor.apply(this, arguments);
      }

      CBox.prototype.mid = function(x, y) {
        return [x + (this.width / 2), y + (this.height / 2)];
      };

      CBox.prototype.render = function() {
        var _ref;
        this.PAPER.style.backgroundColor = this.bcolor;
        this.PAINT.fillStyle = this.fcolor;
        this.PAINT.strokeStyle = this.scolor;
        this.PAINT.lineWidth = (_ref = this.size) != null ? _ref : 1;
        this.PAINT.beginPath();
        this.PAINT.rect(this.x, this.y, this.width, this.height);
        this.PAINT.closePath();
        if (!this.noFill) {
          this.PAINT.fill();
        }
        if (this.doStroke) {
          this.PAINT.stroke();
        }
        return this;
      };

      return CBox;

    })(CNode);
    CSquare = (function(_super) {
      __extends(CSquare, _super);

      function CSquare(Pappai, side) {
        this.give("side", side);
        CSquare.__super__.constructor.apply(this, arguments);
      }

      CSquare.prototype.mid = function(x, y) {
        return [x + (this.side / 2), y + (this.side / 2)];
      };

      CSquare.prototype.render = function() {
        var _ref;
        this.PAPER.style.backgroundColor = this.bcolor;
        this.PAINT.fillStyle = this.fcolor;
        this.PAINT.strokeStyle = this.scolor;
        this.PAINT.lineWidth = (_ref = this.size) != null ? _ref : 1;
        this.PAINT.beginPath();
        this.PAINT.fillRect(this.x, this.y, this.side, this.side);
        this.PAINT.closePath();
        if (!this.noFill) {
          this.PAINT.fill();
        }
        if (this.doStroke) {
          this.PAINT.stroke();
        }
        return this;
      };

      return CSquare;

    })(CNode);
    CText = (function(_super) {
      __extends(CText, _super);

      function CText(Pappai, font, size) {
        this.give("font", font);
        this.give("size", size);
        CText.__super__.constructor.apply(this, arguments);
      }

      CText.prototype.mid = function(x, y) {
        return [x, y];
      };

      CText.prototype.render = function(words) {
        var font, size, _ref, _ref1;
        font = (_ref = this.font) != null ? _ref : "Helvetica Neue";
        size = (_ref1 = this.size) != null ? _ref1 : 16;
        this.PAPER.style.backgroundColor = this.bcolor;
        this.PAINT.font = "" + size + "pt " + font;
        this.PAINT.fillStyle = this.fcolor;
        this.PAINT.beginPath();
        this.PAINT.fillText(words, this.x, this.y);
        this.PAINT.closePath();
        return this;
      };

      return CText;

    })(CNode);
    Pappai = {
      Init: function(width, height, theater) {
        var body, canvas, html, xm, ym;
        canvas = document.createElement("canvas");
        canvas.id = "pappai";
        document.body.appendChild(canvas);
        if (theater) {
          html = document.querySelector("html");
          html.style.margin = 0;
          html.style.padding = 0;
          body = document.querySelector("body");
          body.style.margin = 0;
          body.style.padding = 0;
          canvas.width = window.innerWidth;
          canvas.height = window.innerHeight;
          canvas.style.display = "block";
        } else {
          canvas.width = width;
          canvas.height = height;
          xm = (window.innerHeight - height) / 2;
          ym = (window.innerWidth - width) / 2;
          canvas.style.margin = "" + xm + "px " + ym + "px";
          canvas.style.display = "block";
        }
        return (function(ctx) {
          ctx.width = ctx.canvas.width;
          ctx.height = ctx.canvas.height;
          ctx.clear = function() {
            return this.clearRect(0, 0, this.width, this.height);
          };
          return ctx;
        })(canvas.getContext("2d"));
      },
      Node: function() {
        return new CNode();
      },
      Circle: function(radius) {
        return new CCircle(this, radius);
      },
      Box: function(width, height) {
        return new CBox(this, width, height);
      },
      Square: function(side) {
        return new CSquare(this, side);
      },
      Text: function(font, size) {
        return new CText(this, font, size);
      }
    };
    return Pappai;
  });

}).call(this);
