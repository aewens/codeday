// Generated by CoffeeScript 1.7.1
(function() {
  define(["jquery", "keys", "store", "user", "helper"], function($, Keys, Store, User, _) {
    return {
      commands: {
        newline: function(enter, e, edit) {
          if (!(enter === Keys.enter && !$("#dialog").is(":visible"))) {
            return;
          }
          return edit.line();
        },
        load: function(l, e, edit) {
          var ctrl;
          ctrl = Keys.pressed[Keys.ctrl];
          if (!(ctrl && (l === Keys.l))) {
            return;
          }
          e.preventDefault();
          edit.buffer = _.selected();
          return $("#save").text("Loaded");
        },
        dialog: function(p, e, edit) {
          var ctrl, shift;
          ctrl = Keys.pressed[Keys.ctrl];
          shift = Keys.pressed[Keys.shift];
          if (!(ctrl && shift && (p === Keys.p))) {
            return;
          }
          e.preventDefault();
          return $("#dialog").show().focus().attr("placeholder", "Command...").on("keyup", function(e) {
            var cmd;
            if (e.keyCode === Keys.enter) {
              cmd = $(this).val();
              if (User[cmd] !== void 0) {
                User[cmd](e, edit);
              }
              $(this).val("").hide();
              return $("textarea").focus();
            } else if (e.keyCode === Keys.esc) {
              $(this).val("").hide();
              return $("textarea").focus();
            }
          });
        },
        savefile: function(s, e, edit) {
          if (!(Keys.pressed[Keys.ctrl] && s === Keys.s)) {
            return;
          }
          e.preventDefault();
          return $("#dialog").show().focus().attr("placeholder", "File name...").on("keyup", function(e) {
            var store;
            if (e.keyCode === Keys.enter) {
              store = new Store($("#dialog"), $("textarea"), $("#files"), $("#info"), $("#save"));
              store.saveFile($("#dialog").val(), $("textarea").val());
              store.listFiles();
              return $(this).val("").hide();
            } else if (e.keyCode === Keys.esc) {
              $(this).val("").hide();
              return $("textarea").focus();
            }
          });
        }
      },
      run: function(key, e, edit) {
        var cmd, _results;
        _results = [];
        for (cmd in this.commands) {
          _results.push(this.commands[cmd](key, e, edit));
        }
        return _results;
      }
    };
  });

}).call(this);
