define ["jquery"], ($) ->
    return {
        selected: -> window.getSelection().toString()
        flip: (text) -> text.split("").reverse().join("")
        upper: (text) -> text.toUpperCase()
        lower: (text) -> text.toLowerCase()
        editor: $("textarea")
    }
