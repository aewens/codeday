// Generated by CoffeeScript 1.7.1
(function() {
  var Physics,
    __slice = [].slice;

  Physics = (function() {
    function Physics(code, level, you, darkness) {
      if (M(code, you).all()) {
        this.universe = code.canvas;
        this.world = code.ctx;
        this.level = level;
        this.unit = code.unit;
        this.keys = code.keyState;
        this.you = you;
        this.darkness = darkness;
        this.objects = [];
        this.mobs = [];
        this.blocks = level.blocks;
        this.last = false;
        this.add(this.blocks);
      } else {
        throw new TypeError("There is nothing. You are nothing.");
      }
    }

    Physics.prototype.addMobs = function() {
      var xs;
      xs = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      this.mobs = Mu.apply(null, xs).into(this.mobs);
      return this.objects = Mu.apply(null, xs).into(this.objects);
    };

    Physics.prototype.add = function() {
      var xs;
      xs = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      return this.objects = Mu.apply(null, xs).into(this.objects);
    };

    Physics.prototype.gravity = function(obj) {
      obj.y = obj.y + (this.unit / 16);
      if (M(obj.light).bool()) {
        return obj.light.y = obj.light.y + (this.unit / 16);
      }
    };

    Physics.prototype.update = function() {
      var b, mob, prev, x, y, _i, _j, _k, _len, _len1, _len2, _ref, _ref1, _ref2, _ref3;
      prev = new Vector2(this.you.x, this.you.y);
      if (!((this.you.ground || this.you.jumping) && !this.you.falling)) {
        this.gravity(this.you);
      }
      _ref = this.mobs;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        mob = _ref[_i];
        mob.prev = new Vector2(mob.x, mob.y);
        if (!(mob.ground && !mob.falling)) {
          this.gravity(mob);
        }
        mob.update(this.you, this.unit, this.world);
      }
      this.you.update(this.keys, this.unit, this.universe);
      _ref1 = this.blocks;
      for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
        b = _ref1[_j];
        _ref2 = this.mobs;
        for (_k = 0, _len2 = _ref2.length; _k < _len2; _k++) {
          mob = _ref2[_k];
          if (mob.collide(b)[1]) {
            mob.y = mob.prev.y;
            mob.ground = true;
            mob.falling = false;
          }
        }
        _ref3 = this.you.collide(b), x = _ref3[0], y = _ref3[1];
        if (x) {
          this.you.x = prev.x;
        }
        if (y) {
          this.you.y = prev.y;
          this.you.ground = true;
          this.you.falling = false;
        }
      }
      return this.you.light.update(this.you.x, this.you.y);
    };

    Physics.prototype.render = function() {
      var self;
      self = this;
      this.world.clearRect(0, 0, this.universe.width, this.universe.height);
      this.level.render(this.world, this.unit);
      this.darkness.render(this.world);
      this.you.render(this.world);
      this.you.light.render(this.world, this.unit);
      return this.objects.map(function(obj) {
        return obj.render(self.world);
      });
    };

    return Physics;

  })();

  window.Physics = Physics;

}).call(this);
