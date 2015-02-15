define ["jquery", "mods/dom"], ($, Dom) ->
    class Edit
        constructor: (editor) ->
            @editor = editor
            @lines  = $("#lines")
            @editor.focus()
            
            # Location data
            @cx = 0
            @cy = 0
            @lineCount = 0
            
            # Initialize first line
            @line()
        line: ->
            @lineCount = @lineCount + 1
            lines  = (new Dom).find("#lines").element
            @lines.append(
                $("<li/>").attr("line", @lineCount)
                          .text(@lineCount)
            )
            
    return Edit
