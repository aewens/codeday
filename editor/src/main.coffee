require.config
    urlArgs: "nocache=" + (new Date).getTime()
    paths: 
        "jquery":     "../vendor/jquery.min"
        "underscore": "../vendor/underscore-min"
        
require [
    "jquery",
    "layout",
    "grid",
    "events",
], ($, Layout, Grid, Events) ->
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
            events = new Events(new Grid(new Layout))
            $("#load").remove()
            $("#app").css("opacity", 1)
            events.press()
        setTimeout(go, 100)
