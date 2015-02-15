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
    $(document).ready ->
        events = new Events(new Grid(new Layout))
        events.press()
