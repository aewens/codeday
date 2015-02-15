// Generated by CoffeeScript 1.7.1
(function() {
  define(["jquery", "mods/dom"], function($, Dom) {
    var Grid;
    Grid = (function() {
      function Grid(editor) {
        this.editor = editor;
        this.$editor = $(this.editor);
        this.lx = 0;
        this.ly = 0;
        this.cx = 0;
        this.cy = 0;
        this.tw = 10;
        this.th = 25;
        this.ew = this.$editor.width();
        this.eh = this.$editor.height();
        this.ux = Math.floor(this.ew / this.tw);
        this.uy = Math.floor(this.eh / this.th);
        this.espace();
        this.cursor = {};
        this.cursor.on = true;
        this.cursor.element = null;
        this.cursor.style = 0;
        this.curse();
        this;
      }

      Grid.prototype.make = function(here, there) {
        return $((new Dom).create(here).into(there).element);
      };

      Grid.prototype.curse = function() {
        var blink;
        if (this.cursor.element === null) {
          this.cursor.element = this.$editor.children().addClass("cursor");
          this.fg = this.cursor.fg = this.cursor.element.css("color");
          this.bg = this.cursor.bg = this.cursor.element.css("background-color");
          blink = function() {
            var bg, fg;
            switch (this.cursor.style) {
              case 0:
                fg = this.cursor.fg;
                bg = this.cursor.bg;
                this.cursor.element.css("background", fg);
                this.cursor.element.css("color", bg);
                this.cursor.fg = bg;
                this.cursor.bg = fg;
                break;
              default:
                fg = this.cursor.fg;
                bg = this.cursor.bg;
                this.cursor.element.css("background", fg);
                this.cursor.element.css("color", bg);
                this.cursor.fg = bg;
                this.cursor.bg = fg;
            }
            return this.cursor.on = !this.cursor.on;
          };
          return setInterval(blink.bind(this), 500);
        } else {
          this.cursor.element.removeClass("cursor");
          return this.cursor.element = $(".espace[x='" + this.cx + "'][y='" + this.cy + "']").addClass("cursor");
        }
      };

      Grid.prototype.espace = function() {
        return this.make("div", editor).width(10).height(25).addClass("espace").attr("x", this.lx).attr("y", this.ly).css({
          top: this.ly * this.uy,
          left: this.lx * this.tw
        });
      };

      Grid.prototype.type = function(pos, val) {
        var x, y;
        x = pos % this.ux;
        y = Math.floor(pos / this.ux);
        this.cursor.element.text(val);
        this.cursor.element.css("color", this.fg);
        this.cursor.element.css("background", this.bg);
        if (x > this.ux) {
          this.lx = this.cx = 0;
          this.ly = this.cy = y;
          this.espace();
          return this.curse();
        } else {
          this.lx = this.cx = x;
          this.ly = this.cy = y;
          this.espace();
          return this.curse();
        }
      };

      return Grid;

    })();
    return Grid;
  });

}).call(this);