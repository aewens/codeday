define ["jquery", "mods/dom", "commands"], ($, Dom, cmd) ->
    class Edit
        constructor: (editor) ->
            @editor = editor
            @lines  = $("#lines")
            @editor.focus()
            
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
        line: ->
            @lineCount = @lineCount + 1
            lines  = (new Dom).find("#lines").element
            @lines.append(
                $("<li/>").attr("line", @lineCount)
                          .text(@lineCount)
            )
        run: (key, e) ->
            cmd.run(key, e, @)
            
    return Edit
