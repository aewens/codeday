// Generated by CoffeeScript 1.7.1
(function() {
  define(function() {
    var Vector;
    Vector = (function() {
      function Vector(x, y) {
        this.x = x;
        this.y = y;
      }

      Vector.prototype.inc = function(s) {
        return new Vector(this.x + s, this.y + s);
      };

      Vector.prototype.dec = function(s) {
        return new Vector(this.x - s, this.y - s);
      };

      Vector.prototype.scale = function(s) {
        return new Vector(this.x * s, this.y * s);
      };

      Vector.prototype.shrink = function(s) {
        return new Vector(this.x / s, this.y / s);
      };

      Vector.prototype.add = function(v) {
        return new Vector(this.x + v.x, this.y + v.y);
      };

      Vector.prototype.sub = function(v) {
        return new Vector(this.x - v.x, this.y - v.y);
      };

      Vector.prototype.norm = function() {
        return new Vector(this.x / this.mag(), this.y / this.mag());
      };

      Vector.prototype.mag = function() {
        return sqrt(sqre(this.x) + sqre(this.y));
      };

      Vector.prototype.mag2 = function() {
        return this.x * this.x + this.y * this.y;
      };

      Vector.prototype.dot = function(v) {
        return this.x * v.x + this.y * v.y;
      };

      Vector.prototype.dot2 = function(u, v) {
        return u.x * v.x + u.y * v.y;
      };

      Vector.prototype.theta = function(v) {
        return acos(this.dot2(this.norm(), v.norm()));
      };

      return Vector;

    })();
    return Vector;
  });

}).call(this);
