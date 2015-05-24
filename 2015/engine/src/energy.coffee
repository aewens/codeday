define [
    "vector"
], (Vector) ->
    class Energy
        # E = k(xmh/r^(p-q))
        constructor: ->
            @E = 500
            @low = 100
            @reset = 500
            @cap = 9000
        check: (k, x, m, h, r, p, q) ->
            (k * x * m * h) / (pow(r, p - q))
        calc: (k, x, m, h, r, p, q) ->
            total = (k * x * m * h) / (pow(r, p - q))
            @E = @E - total
            @E = 0 if @E < 0
            total
        update: (time) ->
            @E = @E + 20 if time % 5 is 0
            @E = @cap if @E >= @cap
        
    return Energy
