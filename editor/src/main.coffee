require.config
    urlArgs: "nocache=" + (new Date).getTime()
    paths: 
        "jquery":     "../vendor/jquery.min"
        "underscore": "../vendor/underscore-min"
        
require [
    "jquery",
    "layout"
], ($, Layout) ->
    $(document).ready ->
        layout = new Layout("#app")
        layout.move()
