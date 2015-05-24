define [
    "state", 
    "pappai",
    "vector",
    "player",
    "ai",
    "block",
    "map",
    "level",
    "energy",
    "universe"
], (State, Pappai, Vector, Player, AI, Block, Map, Level, Energy, Universe) ->
    class GameState extends State
        constructor: (game) ->
            super game
            
            @w = @game.canvas.ctx.width
            @h = @game.canvas.ctx.height
            
            # @map = new Map(27, 12, 40)
            # @map.row(11, "platform")
            # @map.fromR(4, 7, 5, "platform")
            # @map.fromR(16, 4, 5, "platform")
            
            @level = new Level(27, 12, 40)
            @map = @level.start()
            
            @time = 0
            
            @energy = new Energy()
            @universe = new Universe(@energy)
            
            @load()
        lvlup: ->
            return if @level.current + 1 is @level.max
            @map = @level.next()
            @energy.E = @energy.reset
            @health = Pappai.Text().set(20, 20)
            @atLevel = Pappai.Text().set(@map.w * @map.size - 20, 20)
            @load()
        load: ->
            @ais = []
            @mobs = pow(2, @level.current)
            @dead_ais = []
            
            for i in [0...@mobs]
                aix = floor(random() * 800) + 100
                aiy = floor(random() * 200)
                ai = new AI(aix, aiy, 20, @mobs, "#f00")
                @ais.push ai
                
            @player = new Player(60, @h - 200, 20, @mobs, "#00f")
            
            @health = Pappai.Text().set(20, 20)
            @atLevel = Pappai.Text().set(20, 40)
            @enLeft = Pappai.Text().set(20, 60)
        handleInputs: (input) ->
            # if input.x != null and input.y != null
            #     @player.real.set(input.x, input.y)
            #     @player.logic = new Vector(input.x, input.y)
            if input.isDown("left")
                @player.move(-1, 0)
            if input.isDown("right")
                @player.move(1, 0)
            if input.isPressed("spacebar")
                @player.move(0, -40) if @player.canJump
            if input.isDown("pulse")
                unless @player.dead
                    @player.pulsate = true
                    @player.pulsing = @player.pulsing + 0.001
            else
                @player.pulsate = false
                @player.pulsing = 0
                
            if input.isPressed("skip") then @lvlup()
        update: ->
            @time = (@time + 1) % 10000
            @energy.update(@time)
            @universe.update(@time, @ais, @player)
            @map.update(@player)
            @player.update(@map, @energy)
            for i in [0...@mobs]
                continue if @ais[i].dead
                others = []
                for j in [0...@mobs]
                    others.push @ais[j] if i isnt j
                @ais[i].update(@map, @player, others)
                @dead_ais.push @ais[i] if @ais[i].dead
            @lvlup() if @dead_ais.length is @ais.length
        render: (ctx) ->
            ctx.clear()
            @player.render()
            @ais[i].render() for i in [0...@mobs]
            @map.render()
            if @player.pulsate and @energy.E > @energy.low
                @player.pulsar.set(@player.logic.x, @player.logic.y)
                @player.pulsar.render()
            life = floor(@player.health)
            life = if life > 0 then life else "Dead"
            @health.render("HP: " + life)
            @atLevel.render("Level: " + floor(@level.current + 1))
            @enLeft.render("Energy: " + floor(@energy.E))
    return GameState
