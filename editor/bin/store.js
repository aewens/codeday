// Generated by CoffeeScript 1.7.1
(function() {
  define(["jquery"], function($) {
    var Storage;
    Storage = (function() {
      function Storage(fileName, fileText, fileList, fileInfo, fileSave) {
        localStorage["mu_files"] = localStorage["mu_files"] || JSON.stringify([]);
        this.fileName = fileName;
        this.fileText = fileText;
        this.fileList = fileList;
        this.fileInfo = fileInfo;
        this.fileSave = fileSave;
        this;
      }

      Storage.prototype.loadFile = function(filename) {
        var ret, s, store, _i, _len;
        ret = null;
        store = JSON.parse(localStorage["mu_files"]);
        for (_i = 0, _len = store.length; _i < _len; _i++) {
          s = store[_i];
          if (s.name === filename) {
            ret = s;
          }
        }
        this.fileInfo.html(ret.name);
        this.fileSave.html("*");
        return this.fileText.html(ret.text);
      };

      Storage.prototype.displayEntries = function(entries) {
        var delLink, entry, li, link, self, _i, _len, _results;
        this.fileList.html("");
        _results = [];
        for (_i = 0, _len = entries.length; _i < _len; _i++) {
          entry = entries[_i];
          li = $("<li/>");
          li.addClass("file");
          link = $("<a/>");
          link.html(entry.name);
          link.addClass("edit-file");
          li.append(link);
          delLink = $("<a/>");
          delLink.html(" [x]");
          delLink.addClass("del-file");
          li.append(delLink);
          this.fileList.append(li);
          self = this;
          link.on("click", function(e) {
            e.preventDefault();
            return self.loadFile(entry.name);
          });
          _results.push(delLink.on("click", function(e) {
            e.preventDefault();
            return self.deleteFile(entry.name);
          }));
        }
        return _results;
      };

      Storage.prototype.listFiles = function() {
        var entries;
        entries = JSON.parse(localStorage["mu_files"]);
        return this.displayEntries(entries.sort().reverse());
      };

      Storage.prototype.saveFile = function(filename, text) {
        var store;
        store = JSON.parse(localStorage["mu_files"]);
        store.push({
          name: filename,
          text: text
        });
        localStorage["mu_files"] = JSON.stringify(store);
        this.fileName.val("");
        this.fileText.html("");
        return this.fileSave.html("Saved");
      };

      Storage.prototype.deleteFile = function(filename) {
        var list, s, store, _i, _len;
        store = JSON.parse(localStorage["mu_files"]);
        list = [];
        for (_i = 0, _len = store.length; _i < _len; _i++) {
          s = store[_i];
          if (s.name !== filename) {
            list.push(s);
          }
        }
        localStorage["mu_files"] = JSON.stringify(list);
        this.listFiles();
        return this.fileSave.html("Deleted");
      };

      return Storage;

    })();
    return Storage;
  });

}).call(this);
