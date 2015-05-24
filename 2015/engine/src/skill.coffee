define [
    "player",
    "pappai"
], (Player, Pappai) ->
    class Skill extends Player
        constructor: (@x, @y, @r, @difficulty, @color) ->
            super(@x, @y, @r, @difficulty, @color)
            
            opts  =
                fcolor: "hsla(60, 100%, 50%, 0.5)"
                scolor: "hsl(80, 100%, 50%)"
                doStroke: true
            @mpulsar = Pappai.Circle(@r + 5).flag(opts)
            @mpulsate = false
            @mpulsing = 0
            @cap = 10
        stats: (@konst, @xup, @M, @prune, @quell, @power) ->
            @E = 
                k: @konst
                x: @xup
                m: @M
                h: @health
                r: 1
                p: @prune
                q: @quell
        mana: (potency, sum, distance, greed) ->
            @M = @M + (potency * sum) / (pow(distance, greed))
        energy: (energy) ->
            @E = 
                k: @konst
                x: @xup
                m: @M
                h: @health
                r: @pulsar.radius
                p: @prune
                q: @quell
            energy.check(@E.k, @E.x, @E.m, @E.h, @E.r, @E.p, @E.q)
        pulse: (energy) ->
            @pulsar.radius = @real.radius + abs(sin(@pulsing * 2)) * 500
            # E = k(xmh/r^(p-q))
            if floor(@pulsing * 100) % 5 is 0
                @E = 
                    k: @konst
                    x: @xup
                    m: @M
                    h: @health
                    r: @pulsar.radius
                    p: @prune
                    q: @quell
                @damage = energy.calc(@E.k, @E.x, @E.m, @E.h, @E.r, @E.p, @E.q)
                @M = @M - @damage
                @M = 1 if @M < 1
        mpulse: (level) ->
            return if @M > 300
            @mpulsar.radius = @real.radius + abs(sin(@mpulsing * 25)) * 50
            # M = a(n/r^b)
            if floor(@mpulsing * 10) % 5 is 0
                sum = pi * sqre(@mpulsar.radius) / 1000
                greed = 2
                @mana(@power, sum, @mpulsar.radius, greed)
                level.mana = level.mana - @M
                level.mana = @cap if level.mana < @cap
        update: (map, energy, level) ->
            super(map, energy)
            @pulse(energy) if @pulsate and energy.E > energy.low
            @mpulse(level) if @mpulsate
        render: ->
            super
