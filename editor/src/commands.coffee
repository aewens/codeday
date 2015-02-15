define ["keys", "store", "mods/rgx"], (Keys, Store, Rgx) ->
    return {
        commands:
            newline: (enter, e, edit) ->
                unless enter is Keys.enter and !$("#dialog").is(":visible")
                    return 
                edit.line()
            # bracket: (open, e, edit) ->
            #     a = open is Keys.open
            #     b = Keys.pressed[Keys.shift]
            #     c = open is Keys.comma
            #     d = open is Keys[9]
            #     return unless (a or (b and (c) or (d)))
            #     select = (text, at) ->
            #         part = text.slice(at-1,at)
            #         index  = text.indexOf(part)
            #         length = part.length
            #         before = text.slice(0, index)
            #         after  = text.slice(index + length)
            #         [before, part, after]
            #     ta = document.querySelector("textarea")
            #     to = ta.selectionEnd
            #     tr = window.getSelection().getRangeAt(0)
            #     tc = tr.collapse(false)
            #     console.log tc
            #     [before, text, after] = select($("textarea").val(), to)
            #     console.log before, text, after
            #     $("textarea").val("#{before}#{text})#{after}")
            #     console.log to
            #     $("#textarea").select()
            savefile: (s, e, edit) ->
                return unless Keys.pressed[Keys.ctrl] and s is Keys.s
                e.preventDefault()
                $("#dialog").show().focus().attr("placeholder", "File name...")
                            .on "keyup", (e) ->
                                if e.keyCode is Keys.enter
                                    store = new Store(
                                        $("#dialog"),
                                        $("textarea"),
                                        $("#files"),
                                        $("#info"),
                                        $("#save")
                                    )
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
