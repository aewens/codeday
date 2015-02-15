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
], ($, Layout, Edit, Events) ->
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
            $("#load").remove()
            $("#app").css("opacity", 1)
            events.press()
        setTimeout(go, 100)
