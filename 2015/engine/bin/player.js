// Generated by CoffeeScript 1.7.1
(function() {
  define(["pappai", "vector"], function(Pappai, Vector) {
    var Player;
    Player = (function() {
      function Player(x, y, r, color) {
        var opts;
        this.x = x;
        this.y = y;
        this.r = r;
        this.color = color;
        this.Reecelet = Pappai.Circle(this.r).fg(this.color).set(this.x, this.y);
        this.Ewensian = new Vector(this.x, this.y);
        this.type = true;
        this.real = this.Reecelet;
        this.logic = this.Ewensian;
        this.collided = false;
        this.into = null;
        this.name = random().toString(36).substr(2, 8);
        this.G = 5;
        this.gravity = new Vector(0, this.G);
        this.velocity = new Vector(0, 0);
        this.friction = 0.9;
        this.canJump = false;
        this.health = 100;
        opts = {
          fcolor: "hsla(180, 100%, 50%, 0.5)",
          scolor: "hsl(200, 100%, 50%)",
          doStroke: true
        };
        this.pulsar = Pappai.Circle(this.r + 5).flag(opts);
        this.pulsate = false;
        this.pulsing = 0;
        this.E = {
          k: 1000,
          x: 1,
          m: 1,
          h: this.health,
          r: this.pulsar.radius,
          p: 2,
          q: 0
        };
      }

      Player.prototype.move = function(x, y) {
        return this.velocity = this.velocity.add2(x, y);
      };

      Player.prototype.collide = function(map) {
        var collided, ctc, cts, h, logic, object, objr, objs, objx, objy, real, self, w, _i, _len, _ref;
        w = map.w * map.size;
        h = map.h * map.size;
        if (this.logic.x < this.r) {
          this.logic = new Vector(this.r, this.logic.y);
        }
        if (this.logic.x >= w - this.r) {
          this.logic = new Vector(w - this.r - 1, this.logic.y);
        }
        if (this.logic.y < this.r) {
          this.logic = new Vector(this.logic.x, this.r);
        }
        if (this.logic.y >= h - this.r) {
          this.logic = new Vector(this.logic.x, h - this.r - 1);
        }
        self = this;
        logic = this.logic;
        ctc = function(c, r) {
          return self.r + r > c.sub(self.logic).mag();
        };
        cts = function(x, y, s) {
          var c, cx, cy, d2;
          cx = clamp(self.logic.x, x, x + s);
          cy = clamp(self.logic.y, y, y + s);
          c = new Vector(cx, cy);
          d2 = ceil(self.logic.sub(c).mag());
          return d2 < self.r;
        };
        collided = false;
        _ref = map.world;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          object = _ref[_i];
          if (collided) {
            continue;
          }
          logic = object.logic;
          real = object.real;
          objx = real.x;
          objy = real.y;
          if (real.side != null) {
            objs = real.side;
          }
          if (real.radius != null) {
            objr = real.radius;
          }
          collided = object.type ? ctc(logic, objr) : cts(objx, objy, objs);
          if (collided) {
            this.into = object;
          }
        }
        this.collided = collided;
        return this.collided;
      };

      Player.prototype.pulse = function(energy) {
        var total;
        this.pulsar.radius = this.real.radius + abs(sin(this.pulsing)) * 500;
        if (floor(this.pulsing * 100) % 5 === 0) {
          this.E = {
            k: 100,
            x: 1,
            m: 1,
            h: this.health,
            r: this.pulsar.radius,
            p: 2,
            q: 0
          };
          return total = energy.calc(this.E.k, this.E.x, this.E.m, this.E.h, this.E.r, this.E.p, this.E.q);
        }
      };

      Player.prototype.update = function(map, energy) {
        var dir;
        this.velocity = this.velocity.scale(this.friction);
        this.logic = this.logic.add(this.gravity).add(this.velocity);
        if (this.pulsate && energy.E > energy.reset) {
          this.pulse(energy);
        }
        if (this.collide(map)) {
          dir = this.into.logic.sub(this.logic).dot(this.gravity);
          if (dir >= 39) {
            this.logic = this.logic.sub(this.gravity);
            this.canJump = true;
          } else if (dir <= -39) {

          } else {

          }
        } else {
          this.canJump = false;
        }
        return this.real.set(this.logic.x, this.logic.y);
      };

      Player.prototype.render = function() {
        return this.real.render();
      };

      return Player;

    })();
    return Player;
  });

}).call(this);
