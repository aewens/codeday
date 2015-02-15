define ["keys"], (Keys) ->
    return {
        isset: (key) -> Keys.pressed[key]
        commands:
            newline: (enter, edit) ->
                return unless enter is Keys.enter
                edit.line()
        run: (key, edit) ->
            for cmd of @commands
                @commands[cmd](key, edit)
    }
