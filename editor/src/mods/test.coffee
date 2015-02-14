define ->
    class Test
        constructor: ->
            @_tests = []
        test: (res, expect) -> @_tests.push [res is expect, res, expect]
        check: ->
            fails = 0
            index = 0
            for t in @_tests
                if not t[0]
                    fails = fails + 1
                    console.log "---"
                    console.log index, t[1], t[2]
                    console.log "---"
                index = index + 1
            console.log "#{fails}/#{index} failed"
    return new Test
