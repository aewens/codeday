# Identity function
id = (x) -> x

# Maybe
M = (xs...) ->
    if xs.length > 1
        return (new ML(xs))
    else
        x = xs[0]
        if x is null or x is undefined or x.length <= 0 or x is false
            return M.None()
        else
            if x instanceof M 
                return x 
            else 
                return M.Some(x)
M.error = "I'm sorry Dave, I'm afraid I can't do that"
M.Some = (x) -> new M.fn.init(true, x)
M.None =     -> new M.fn.init(false, null)
M.fn = M.prototype =
    init: (usable, x) ->
        @usable = usable
        throw @error if x == null and usable
        @x = x
        @
    maybe: (x) -> new M(x)
    of: (x) -> M(x)
    orSome: (x) -> if @usable then @x else x
    orElse: (x) -> if @usable then @  else x
    otherwise: (x) -> @orSome(x)
    elser: (x) -> @orElse(x)
    choose: (x, y) -> if @x then x else y
    swap: (x, y) -> @x = if @x then x else y
    bind: (fn) -> if @usable then fn(@x) else @
    lift: (fn) -> if @usable then new M(fn(@x)) else new M(@)
    bind2: (y) ->
        self = this
        (fn) -> fn(self.x, y)
    lift2: (y) ->
        self = this
        (fn) -> new M(fn(self.x,y.x))
    fmap: (fn) -> 
        self = this
        (ms...) -> [self].concat(ms).reduce (a,b) -> new M(fn(a.x,b.x))
    some: -> if @usable then @x else throw M.error
    isSome: -> @usable
    isNone: -> !@isSome()
    toString: -> if @usable then "Some(#{@x})" else "None"
    to_s: -> @toString()
    show: -> @some()
M.fn.init.prototype = M.fn

# MaybeList
ML = (xs) ->
    if xs instanceof ML
        xs
    else
        if xs instanceof Array
            @xs = xs.map (x) -> M(x)
        else
            @xs = [M(xs)]
        @        
ML.fn = ML.prototype
ML.fn.all = ->
    l0 = @xs.length
    l1 = @xs.filter((x) -> x.isSome()).length
    if l0 == l1 then true else false
ML.fn.any = -> 
    if @xs.filter((x) -> x.isSome()).length > 0 then true else false
ML.fn.unwrap = -> @xs.map (x) -> x.x
ML.fn.bind = (f) -> @xs.map (x) -> x.bind(f)
ML.fn.fmap = (f) -> new ML(@xs.map (x) -> x.bind(f))
ML.fn.otherwise = (x) -> if @all() then @xs else x
ML.fn.elsewise = (x) -> if @any() then new ML(@xs).bind(id) else x
ML.fn.diverge = (x) -> @elsewise(x)
ML.fn.elser = (x) -> if @any() then true else x
ML.fn.pick = (f, g) -> if @all() then new ML(@xs).bind(f) else g
ML.fn.select = (f, g) -> if @any() then new ML(@xs).bind(f) else g
ML.fn.choose = (x, y) -> if @all() then x else y
ML.fn.some = -> @xs.filter((x) -> x.isSome).map (x) -> x.x
    
window.M  = M
window.ML = ML
