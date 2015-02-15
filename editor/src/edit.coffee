define ["jquery", "mods/dom", "commands", "layout"], ($, Dom, cmd, Layout) ->
    class Edit
        constructor: (editor) ->
            @editor = editor
            @lines  = $("#lines")
            @editor.focus()
            
            @buffer = null
            
            # Location data
            @cx = 0
            @cy = 0
            @lineCount = 0
            
            # Text data
            @tw = @editor.css("font-size") - 4
            @th = @editor.css("font-size") + 11
            @cw = @editor.width()
            @ch = @editor.height()
            @ux = Math.floor(@cw / @tw)
            @uy = Math.floor(@ch / @th)
            
            # Initialize first line
            @line()
            
            self = @
            window.addEventListener "resize", (e) ->
                (new Layout).resize()
                setTimeout((-> self.editor.focus()), 500)
        line: ->
            @lineCount = @lineCount + 1
            lines  = (new Dom).find("#lines").element
            @lines.append(
                $("<li/>").attr("line", @lineCount)
                          .text(@lineCount)
            )
        load: (text) ->
            @buffer = text
        run: (key, e) ->
            cmd.run(key, e, @)
            
    return Edit
