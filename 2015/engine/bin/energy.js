// Generated by CoffeeScript 1.7.1
(function() {
  define(["vector"], function(Vector) {
    var Energy;
    Energy = (function() {
      function Energy() {
        this.E = 500;
        this.reset = 100;
      }

      Energy.prototype.calc = function(k, x, m, h, r, p, q) {
        var total;
        total = (k * x * m * h) / (pow(r, p - q));
        this.E = this.E - total;
        if (this.E < 0) {
          return this.E = 0;
        }
      };

      Energy.prototype.update = function(time) {
        if (time % 5 === 0) {
          this.E = this.E + 20;
        }
        if (this.E >= 1000) {
          return this.E = 1000;
        }
      };

      return Energy;

    })();
    return Energy;
  });

}).call(this);