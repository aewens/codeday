// Generated by CoffeeScript 1.7.1
(function() {
  define(["vector"], function(Vector) {
    var Universe;
    Universe = (function() {
      function Universe(energy) {
        this.energy = energy;
        this.snapshots = {};
      }

      Universe.prototype.update = function(time, ais, player) {
        var everything, object, snap, _i, _j, _len, _len1, _results;
        everything = [player].concat(ais);
        if (this.energy.E < this.energy.reset) {
          for (_i = 0, _len = everything.length; _i < _len; _i++) {
            object = everything[_i];
            snap = this.snapshots[object.name];
            object.logic = snap.pos;
            object.velocity = snap.vel;
            object.health = snap.life;
            object.dead = snap.revive;
          }
        }
        if (time % 256 === 0 || Object.keys(this.snapshots).length === 0) {
          this.snapshots = {};
          _results = [];
          for (_j = 0, _len1 = everything.length; _j < _len1; _j++) {
            object = everything[_j];
            snap = {
              pos: object.logic,
              vel: object.velocity,
              life: object.health,
              revive: object.dead
            };
            _results.push(this.snapshots[object.name] = snap);
          }
          return _results;
        }
      };

      return Universe;

    })();
    return Universe;
  });

}).call(this);
