require.config
    urlArgs: "nocache=" + (new Date).getTime()
    paths: 
        "jquery":     "../vendor/jquery.min"
        "underscore": "../vendor/underscore-min"
        
require [
    "jquery",
    "layout",
    "edit",
    "events",
    "store"
], ($, Layout, Edit, Events, Store) ->
    phrases = [
        "ಠ_ಠ",
        # "µText",
        # "Loading",
        # "Installing malware",
        # "Hacking the FBI",
        # "Always watching"
    ]
    $(document).ready ->
        phrase = Math.floor(Math.random() * phrases.length) % phrases.length
        $("#load").html(phrases[phrase])
        go = ->
            events = new Events(new Edit(new Layout))
            $("#dialog").hide()
            $("#load").remove()
            $("#app").css("opacity", 1)
            store = new Store(
                $("#dialog"),
                $("textarea"),
                $("#files"),
                $("#info"),
                $("#save")
            )
            store.listFiles()
            $("a.edit-file").on "click", (e) ->
                e.preventDefault()
                store.loadFile($(this).text())
            events.press(store)
        setTimeout(go, 500)
