Mu = (xs...) ->
    if xs.length > 1
        x = xs
        array = true
        usable = true
        return new Mu.fn.of(x,usable,array)
    else if xs[0].length > 1 and xs[1] is undefined
        x = xs[0]
        array = true
        usable = true
        return new Mu.fn.of(x,usable,array)
    else
        x = xs[0]
        array = false
        if x is null or x is undefined or x.length <= 0 or x is false
            x = null
            usable = false
            return new Mu.fn.of(x,usable,array)
        else
            if x instanceof Mu
                return x
            else
                x = x
                usable = true
                return new Mu.fn.of(x,usable,array)
Mu.fn = Mu.prototype
Mu.fn.of = (x, usable, array) -> 
    [@x, @usable, @array] = [x, usable, array]
    @value = x
    @
Mu.fn.isArray = (x) -> @array
Mu.fn.into = (z) ->
    if @isArray() then @x.map (x) -> z.push(x)
    else z.push(@x)
    return z

Mu.fn.of.prototype = Mu.fn
        
window.Mu = Mu
window.µ = Mu
