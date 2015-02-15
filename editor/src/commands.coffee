define ["keys", "store"], (Keys, Store) ->
    return {
        isset: (key) -> Keys.pressed[key]
        commands:
            newline: (enter, edit) ->
                unless enter is Keys.enter and !$("#dialog").is(":visible")
                    return 
                edit.line()
            # move: (arrow, edit) ->
            #     switch arrow
            #         when Keys.up then edit.cy -= 1 if edit.cy > 0
            #         when Keys.down then edit.cy += 1 if edit.cy < edit.lineCount
            #         when Keys.left
            #             edit.cx -= 1 if edit.cx > 0
            #             console.log edit.cx
            #         when Keys.right then edit.cx += 1 if edit.cx > edit.ux
            #         else
            #             edit.cx += 1
            #             edit.editor.val().slice(0, edit.editor.selectionStart).length
            #     $("#here").html("| #{edit.cx},#{edit.cy} | ")
            savefile: (s, edit) ->
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
                                        $("textarea").html()
                                    )
                                    store.listFiles()
                                    $(this).hide()
                                else if e.keyCode is Keys.esc
                                    $(this).hide()
                                    $("textarea").focus()
        run: (key, edit) ->
            for cmd of @commands
                @commands[cmd](key, edit)
    }
