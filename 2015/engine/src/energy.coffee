define [
    "vector"
], (Vector) ->
    class Energy
        # E = k(xmh/r^(p-q))
        constructor: ->
            @E = 500
            @reset = 100
        calc: (k, x, m, h, r, p, q) ->
            total = (k * x * m * h) / (pow(r, p - q))
            @E = @E - total
            @E = 0 if @E < 0
            total
        update: (time) ->
            @E = @E + 20 if time % 5 is 0
            @E = 9000 if @E >= 9000
        
    return Energy
