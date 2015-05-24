define [
    "pappai",
    "vector"
], (Pappai, Vector) ->
    class Block
        constructor: (@x, @y, @s, @color) ->
            @Reecelet = Pappai.Square(@s).fg(@color).set(@x, @y)
            @Ewensian = new Vector(@x, @y)
            # new Vector(@Reecelet.xx, @Reecelet.yy)
            @type = false # Square
            @real  = @Reecelet
            @logic = @Ewensian
            @collided = false
            @

    return Block
