require.config
    urlArgs: "nocache=" + (new Date).getTime()
    paths: 
        "jquery":     "../vendor/jquery.min"
        "underscore": "../vendor/underscore-min"
        
require [
    "jquery",
    "layout",
    "events",
], ($, Layout, Events) ->
    $(document).ready ->
        layout = new Layout
