define [
    "player",
    "skill",
    "pappai"
], (Player, Skill, Pappai) ->
    class Prophet extends Skill
        constructor: (@x, @y, @r, @difficulty) ->
            super(@x, @y, @r, @difficulty, "#ff0")
            
            @stats(-100, 1, 1, 2, 0, 2)
        heal: ->
            @health = @health + @M
            @M = 1
        # energy: (energy) ->
        #     super(energy)
        # update: (map, energy) ->
        #     super(map, energy)
        # render: ->
        #     super
    
    return Prophet
