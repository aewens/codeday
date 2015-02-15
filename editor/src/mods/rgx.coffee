define ->
    Rgx =
        findSet: (expr) -> (text) -> (start, end) ->
            match = []
            res = []
            regex = new RegExp(expr, "g")
            while match = regex.exec(text)
                res.push []
                for i in [start..end] by 1
                    res[res.length-1].push match[i]
                regex.lastIndex++ if (regex.lastIndex == match.index)
            res
        find: (expr) -> (text) -> 
            Rgx.findSet(expr)(text)(0,1)
        swap: (expr) -> (text) -> (mod) ->
            text.replace(expr, mod)
        peek: (expr) -> (text) ->
            text.search(expr) > -1
        move: (expr) -> (text) ->
            text.split(expr)
    return Rgx
