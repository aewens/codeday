define ["jquery", "keys", "user", "helper"], ($, Keys, User, _) ->
    return {
        commands:
            newline: (enter, e, edit) ->
                unless enter is Keys.enter and !$("#dialog").is(":visible")
                    return 
                edit.line()
            load: (l, e, edit) ->
                ctrl = Keys.pressed[Keys.ctrl]
                return unless ctrl and (l is Keys.l)
                e.preventDefault()
                edit.buffer = _.selected()
                $("#save").text("Loaded")
            dialog: (p, e, edit) ->
                ctrl = Keys.pressed[Keys.ctrl]
                shift = Keys.pressed[Keys.shift]
                return unless ctrl and shift and (p is Keys.p)
                e.preventDefault()
                $("#dialog").show().focus().attr("placeholder", "Command...")
                    .on "keyup", (e) ->
                        if e.keyCode is Keys.enter
                            cmd = $(this).val()
                            User[cmd](e, edit) unless User[cmd] is undefined
                            $(this).val("").hide()
                            $("textarea").focus()
                        else if e.keyCode is Keys.esc
                            $(this).val("").hide()
                            $("textarea").focus()
            savefile: (s, e, edit) ->
                return unless Keys.pressed[Keys.ctrl] and s is Keys.s
                e.preventDefault()
                $("#dialog").show().focus().attr("placeholder", "File name...")
                            .on "keyup", (e) ->
                                if e.keyCode is Keys.enter
                                    store = edit.store
                                    store.saveFile(
                                        $("#dialog").val(),
                                        $("textarea").val()
                                    )
                                    store.listFiles()
                                    $(this).val("").hide()
                                else if e.keyCode is Keys.esc
                                    $(this).val("").hide()
                                    $("textarea").focus()
        run: (key, e, edit) ->
            for cmd of @commands
                @commands[cmd](key, e, edit)
    }
