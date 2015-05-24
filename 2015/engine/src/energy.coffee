define [
    "vector"
], (Vector) ->
    class Energy
        # E = k(xmh/r^(p-q))
        constructor: ->
            @E = 300
            @low = 100
            @reset = 300
            @cap = 1000
        check: (k, x, m, h, r, p, q) ->
            (k * x * m * h) / (pow(r, p - q))
        calc: (k, x, m, h, r, p, q) ->
            total = (k * x * m * h) / (pow(r, p - q))
            @E = @E - total
            @E = 0 if @E < 0
            total
        update: (time) ->
            @E = @E + 10 if time % 5 is 0
            @E = @cap if @E >= @cap
        
    return Energy
