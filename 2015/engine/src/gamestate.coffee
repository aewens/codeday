define [
    "state", 
    "pappai",
    "vector",
    "player",
    "ai",
    "block",
    "map",
    "energy",
    "universe"
], (State, Pappai, Vector, Player, AI, Block, Map, Energy, Universe) ->
    class GameState extends State
        constructor: (game) ->
            super game
            
            @w = @game.canvas.ctx.width
            @h = @game.canvas.ctx.height
            
            @player = new Player(60, @h - 200, 20, "#00f")
            
            @map = new Map(27, 12, 40)
            @map.row(11, "platform")
            @map.fromR(4, 7, 5, "platform")
            @map.fromR(16, 4, 5, "platform")
            
            @time = 0
            
            @energy = new Energy()
            @universe = new Universe(@energy)
            
            @ais = []
            @a = 1
            
            for i in [0...@a]
                aix = floor(random() * 800) + 100
                aiy = floor(random() * 200)
                ai = new AI(aix, aiy, 20, "#f00")
                @ais.push ai
        handleInputs: (input) ->
            # if input.x != null and input.y != null
            #     @player.real.set(input.x, input.y)
            #     @player.logic = new Vector(input.x, input.y)
            if input.isDown("left")
                @player.move(-1, 0)
            if input.isDown("right")
                @player.move(1, 0)
            if input.isPressed "spacebar"
                @player.move(0, -40) if @player.canJump
            if input.isDown "pulse"
                @player.pulsate = true
                @player.pulsing = @player.pulsing + 0.001
            else
                @player.pulsate = false
                @player.pulsing = 0
        update: ->
            # console.log @energy.E
            # console.log @player.health
            if @player.health > 0
                @time = (@time + 1) % 10000
                @energy.update(@time)
                @universe.update(@time, @ais, @player)
                @map.update(@player)
                @player.update(@map, @energy)
                for i in [0...@a]
                    others = []
                    for j in [0...@a]
                        others.push @ais[j] if i isnt j
                    @ais[i].update(@map, @player, others) 
            else
                console.log "Oh no :("
        render: (ctx) ->
            ctx.clear()
            @player.render()
            @ais[i].render() for i in [0...@a]
            @map.render()
            if @player.pulsate and @energy.E > @energy.reset
                @player.pulsar.set(@player.logic.x, @player.logic.y)
                @player.pulsar.render()
    return GameState
