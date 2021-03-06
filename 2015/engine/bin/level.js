// Generated by CoffeeScript 1.7.1
(function() {
  define(["map"], function(Map) {
    var Level, Levels;
    Levels = [[["row", 11, "platform"], ["fromR", 4, 7, 5, "platform"]], [["row", 11, "platform"], ["fromR", 4, 7, 5, "platform"], ["fromR", 16, 4, 5, "platform"]], [["row", 11, "platform"], ["fromR", 4, 7, 5, "platform"], ["fromR", 16, 4, 5, "platform"]], [["row", 11, "platform"], ["fromR", 4, 7, 5, "platform"], ["fromR", 16, 4, 5, "platform"]], [["row", 11, "platform"], ["fromR", 4, 7, 5, "platform"], ["fromR", 16, 4, 5, "platform"]]];
    Level = (function() {
      function Level(w, h, size) {
        this.w = w;
        this.h = h;
        this.size = size;
        this.map = new Map(this.w, this.h, this.size);
        this.max = Levels.length;
        this.current = 0;
        this.mana = 1000;
        this.mreset = 1000;
      }

      Level.prototype.start = function() {
        return this.select(this.current);
      };

      Level.prototype.select = function(lvl) {
        var cmd, level, order, params, _i, _len;
        this.current = lvl;
        level = Levels[lvl];
        for (_i = 0, _len = level.length; _i < _len; _i++) {
          order = level[_i];
          cmd = order[0];
          params = order.slice(1);
          this.map[cmd].apply(this.map, params);
        }
        return this.map;
      };

      Level.prototype.next = function() {
        this.map = new Map(this.w, this.h, this.size);
        this.current = this.current + 1;
        return this.select(this.current);
      };

      return Level;

    })();
    return Level;
  });

}).call(this);
