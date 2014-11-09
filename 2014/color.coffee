class Color
    constructor: (h, s, l, a) ->
        [@h, @s, @l] = M(h, s, l).diverge([0, 0, 0])
        @a = M(a).otherwise(1)
        @value = "hsla(#{@h}, #{@s}%, #{@l}%, #{@a})"
    
window.Color = Color
