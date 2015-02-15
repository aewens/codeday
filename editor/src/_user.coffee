define ["jquery", "helper"], ($, _) ->
    return {
        confusing: (e, edit) ->
            text = edit.buffer
            upper = _.upper
            flip = _.flip
            _.editor.val(upper(flip(text)))
    }
