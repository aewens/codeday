// Generated by CoffeeScript 1.7.1
(function() {
  var Light;

  Light = (function() {
    function Light(player) {
      var _ref;
      this.you = player;
      _ref = [0, 0, 100, 0.6], this.h = _ref[0], this.s = _ref[1], this.l = _ref[2], this.a = _ref[3];
      this.color = new Color(this.h, this.s, this.l, this.a);
      this.radius = this.you.w * 2;
      this.w = this.you.w / 2;
      this.h = this.you.h / 2;
      this.x = this.you.x + this.w;
      this.y = this.you.y + this.h;
    }

    Light.prototype.brightness = function(delta) {
      return this.color = new Color(this.h, this.s, this.l, this.a + delta);
    };

    Light.prototype.ligthen = function() {
      return this.brightness(0.1);
    };

    Light.prototype.darken = function() {
      return this.brightness(-0.1);
    };

    Light.prototype.grow = function() {
      return this.radius = this.radius + 1;
    };

    Light.prototype.shrink = function() {
      if (this.radius >= 0) {
        return this.radius = this.radius - 1;
      }
    };

    Light.prototype.update = function(x, y) {
      this.x = x + this.w;
      return this.y = y + this.h;
    };

    Light.prototype.inside = function(obj) {
      var a, b, c, d, offset;
      offset = M(this.radius).otherwise(0);
      a = obj.contains(this.x + offset, this.y);
      b = obj.contains(this.x - offset, this.y - offset);
      c = obj.contains(this.x, this.y + offset);
      d = obj.contains(this.x, this.y - offset);
      this.hit = M(a, b, c, d).elser(false);
      return this.hit;
    };

    Light.prototype.render = function(ctx) {
      ctx.fillStyle = this.color.value;
      ctx.beginPath();
      ctx.arc(this.x, this.y, this.radius, 0, 2 * pi);
      ctx.fill();
      return ctx.closePath();
    };

    return Light;

  })();

  window.Light = Light;

}).call(this);
