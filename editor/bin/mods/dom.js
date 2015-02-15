// Generated by CoffeeScript 1.7.1
(function() {
  define(function() {
    var Dom;
    Dom = (function() {
      function Dom() {}

      Dom.prototype.create = function(element) {
        this.element = document.createElement(element);
        if (this.isElement(this.element)) {
          return this;
        } else {
          return null;
        }
      };

      Dom.prototype.isElement = function(element) {
        return element instanceof HTMLElement;
      };

      Dom.prototype.into = function(element) {
        if (!this.isElement(element)) {
          console.log("Error #001: (" + element + ")");
          return;
        }
        element.appendChild(this.element);
        return this;
      };

      Dom.prototype.add = function(dom) {
        if (!dom) {
          return;
        }
        if (!this.isElement(dom.element)) {
          console.log("Error #002: (" + dom.element + ")");
          return;
        }
        this.element.appendChild(dom.element);
        return this;
      };

      Dom.prototype.find = function(elem) {
        var element;
        element = document.querySelectorAll(elem)[0];
        if (element === void 0) {
          return null;
        }
        if (element.length === 1) {
          this.element = element[0];
        } else {
          this.element = element;
        }
        return this;
      };

      return Dom;

    })();
    return Dom;
  });

}).call(this);
