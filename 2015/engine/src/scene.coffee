define [
    "map"
], (Map) ->
    class Scene extends Map
        constructor: (@sw, @sh, @w, @h, @size) ->
            super w, h, size
            @row(11, "platform")
            @fromR(4, 7, 5, "platform")
            @viewable = [0, 0, @w*@size, @h*@size]
            @
        getAll: ->
            self = @
            @blocks.filter (block) ->
                return false if block is null
                logic = block.logic
                side = block.real.side
                return false if logic.x < self.viewable[0]
                return false if logic.y < self.viewable[1]
                return false if logic.x + side > self.viewable[2]
                return false if logic.y + side > self.viewable[3]
                return true
        camera: (player) ->
            if player.logic.x > (@w*@size)/2
                @viewable[0] = (player.logic.x - (@w*@size)/2)
                player.frozen.x = true
                player.logic.x = player.logic.x - player.velocity.x
            else
                @viewable[0] = 0
                player.frozen.x = false
                
            if player.logic.y < (@h*@size)/2
                @viewable[1] = (player.logic.y - (@h*@size)/2)
                player.frozen.y = true
            else
                @viewable[1] = 0
                player.frozen.y = false
        update: (player) ->
            @camera(player)
            @world = @getAll()
        render: ->
            blocks = @getAll()
            blocks[i].real.render() for i in [0...blocks.length]
    return Scene
