// Generated by CoffeeScript 1.7.1
(function() {
  define(["pappai"], function(Pappai) {
    var Formulae;
    Formulae = (function() {
      function Formulae(fnx, fny, steps) {
        this.fnx = fnx;
        this.fny = fny;
        this.steps = steps;
        this.nodes = [];
        this.scale = 0;
        this.angle = 0;
        this.shift = {
          x: 0,
          y: 0
        };
        this;
      }

      Formulae.prototype.grow = function(scale) {
        this.scale = scale;
        return this;
      };

      Formulae.prototype.move = function(x, y) {
        this.shift.x = x;
        this.shift.y = y;
        return this;
      };

      Formulae.prototype.rotate = function(inc) {
        return this.angle = this.angle + inc;
      };

      Formulae.prototype.set = function(x, y) {
        this.x = x;
        this.y = y;
        return this;
      };

      Formulae.prototype.cache = function(nodes) {
        this.nodes = nodes;
        return this;
      };

      Formulae.prototype.render = function(ctx, opts) {
        var i, nodes, prev, x, xx, xz, y, yx, yy, yz, _i, _j, _ref, _ref1, _ref2, _ref3, _ref4, _ref5, _ref6;
        prev = {
          x: (_ref = this.x) != null ? _ref : 0,
          y: (_ref1 = this.y) != null ? _ref1 : 0
        };
        ctx.beginPath();
        opts = opts || {};
        if (this.nodes && this.nodes.length === 0) {
          nodes = [];
          for (i = _i = 0, _ref2 = this.steps; 0 <= _ref2 ? _i <= _ref2 : _i >= _ref2; i = 0 <= _ref2 ? ++_i : --_i) {
            x = this.fnx(i, prev.x);
            y = this.fny(i, prev.y);
            prev.x = x;
            prev.y = y;
            x = x * this.scale;
            y = y * this.scale;
            xz = x * cos(this.angle) - y * sin(this.angle);
            yz = x * sin(this.angle) + y * cos(this.angle);
            xx = xz + this.shift.x;
            yx = yz + this.shift.y;
            if (i === 0) {
              ctx.moveTo(xx, yy);
            } else {
              ctx.lineTo(xx, yy);
            }
            nodes.push(x);
            nodes.push(y);
          }
          this.cache(nodes);
        } else {
          for (i = _j = 0, _ref3 = this.nodes.length; _j < _ref3; i = _j += 2) {
            xz = this.nodes[i] * cos(this.angle) - this.nodes[i + 1] * sin(this.angle);
            yz = this.nodes[i] * sin(this.angle) + this.nodes[i + 1] * cos(this.angle);
            xx = xz + this.shift.x;
            yy = yz + this.shift.y;
            if (i === 0) {
              ctx.moveTo(xx, yy);
            } else {
              ctx.lineTo(xx, yy);
            }
          }
        }
        ctx.closePath();
        ctx.lineWidth = (_ref4 = opts.size) != null ? _ref4 : 1;
        ctx.fillStyle = (_ref5 = opts.fcolor) != null ? _ref5 : "#f00";
        ctx.strokeStyle = (_ref6 = opts.scolor) != null ? _ref6 : "#00f";
        if (opts.doStroke) {
          ctx.stroke();
        }
        if (!opts.noFill) {
          ctx.fill();
        }
        return nodes;
      };

      return Formulae;

    })();
    return Formulae;
  });

}).call(this);
