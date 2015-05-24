define [
    "vector"
], (Vector) ->
    class Universe
        constructor: (@energy) ->
            @snapshots = {}
        update: (time, ais, player) ->
            everything = [player].concat(ais)
            if @energy.E < @energy.reset
                for object in everything
                    snap = @snapshots[object.name]
                    object.logic = snap.pos
                    object.velocity = snap.vel
                    object.health = snap.life
                    object.dead = snap.revive
                    # object.E = snap.E if object.E?
            if time % 256 is 0 or Object.keys(@snapshots).length is 0
                @snapshots = {}
                for object in everything
                    snap =
                        pos: object.logic
                        vel: object.velocity
                        life: object.health
                        revive: object.dead
                    # snap.E = object.E if object.E?
                    @snapshots[object.name] = snap
            
    return Universe
