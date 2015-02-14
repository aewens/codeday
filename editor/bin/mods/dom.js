// Generated by CoffeeScript 1.7.1
(function() {
  define(function() {
    var $;
    $ = {
      "new": function() {
        return Object.create($);
      },
      create: function(element) {
        this.element = document.createElement(element);
        if (this.isElement(this.element)) {
          return this;
        } else {
          return null;
        }
      },
      isElement: function(element) {
        return element instanceof HTMLElement;
      },
      into: function(element) {
        if (!this.isElement(element)) {
          console.log("Error #001: (" + element + ")");
          return;
        }
        element.appendChild(this.element);
        return this;
      },
      add: function(dom) {
        if (!dom) {
          return;
        }
        if (!this.isElement(dom.element)) {
          console.log("Error #002: (" + dom.element + ")");
          return;
        }
        this.element.appendChild(dom.element);
        return this;
      },
      find: function(elem) {
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
      }
    };
    return $;
  });

}).call(this);