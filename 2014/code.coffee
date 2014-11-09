class Code
    constructor: ->
        @root = document.querySelector("#wrapper")
        canvas  = document.createElement("canvas")
        cwords  = "Your browser is bad and you should feel bad"
        ctext   = document.createTextNode cwords
        
        @root.appendChild(canvas).appendChild(ctext)
            
        @canvas = canvas
        @ctx    = @canvas.getContext("2d")
        
        @done = false
        
        @dimensions(@root)
        
        @inputs()

        @levelList = [Level0, Level1]
        @levelIndex = 0
        
        @init()
        
        self = @
        window.addEventListener "resize", (e) ->
            self.dimensions(self.root)
            
    init: ->
        @evpg = new EventPage(@)
        if @done
            @evpg.done()
        else
            sy = @unit #@canvas.height - 
            @level = new Level(@currentLevel(), @unit)
            if @levelIndex is 1 then @level.mobs = false
            @darkness = new Box(0, 0, @canvas.width, 
                            @canvas.height, new Color(0,0,0,0.5))
            mob1 = new Mob(@unit * 14, sy, @unit) # - (@unit * round(random() * 10))
            mob2 = new Mob(@unit * 18, sy, @unit) # - (@unit * round(random() * 10))
            mob3 = new Mob(@unit * 20, sy, @unit) # - (@unit * round(random() * 10))
            mob4 = new Mob(@unit * 24, sy, @unit) # - (@unit * round(random() * 10))
            mob5 = new Mob(@unit * 30, sy, @unit) # - (@unit * round(random() * 10))
            @player = new Player(@unit * 2, @canvas.height - (sy * 2), @unit)
            @physics = new Physics(@, @level, @player, @darkness, @evpg)
            
            mobs = [mob1,mob2,mob3,mob4,mob5]

            @physics.addMobs(mobs) if @level.mobs
        
    dimensions: (root) ->
        w = parseInt window.getComputedStyle(root).width
        h = parseInt window.getComputedStyle(root).height
        r0 = 32
        r1 = 9
        r2 = r0 * r1

        x = max(w,h)
        y = max(r0,r1)

        # @unit = pow(2,((floor(log(floor(x/y))/log(2)))))
        @unit = floor(x/y)
        
        @canvas.width  = @unit * r0
        @canvas.height = @unit * r1
        
        m0 = (h - @canvas.height) / 2
        m1 = (w - @canvas.width)  / 2
        
        @canvas.style.margin = "#{m0}px #{m1}px"
        
    resetLevel: -> @init()
    currentLevel: -> @levelList[@levelIndex]
    nextLevel: ->
        @levelIndex = @levelIndex + 1
        if @levelIndex is @levelList.length then return @done = true
        return @currentLevel()
        
    inputs: ->
        @keyState = {}
        self = @
        document.addEventListener "keydown", (e) -> 
            self.keyState[e.keyCode] = true
        document.addEventListener "keyup", (e) -> 
            self.keyState[e.keyCode] = false
        document.addEventListener "dblclick", (e) ->
            self.physics.win = true
        
    animate: (update, render) ->
        self = @
        rf = (x,y) -> window.requestAnimationFrame(x,y)
        l = ->
            update()
            render()
            rf l, self.canvas
        rf l, @canvas
        
code = new Code()

update = ->
    if code.physics.you.dead
        code.evpg.set("end") unless M(code.evpg.text).bool()
        code.evpg.update()
        return
    if code.physics.win
        code.evpg.set("win") unless M(code.evpg.text).bool()
        code.evpg.update()
        return
    else code.physics.update()

render = ->
    if code.physics.you.dead
        code.evpg.set("end") unless M(code.evpg.text).bool()
        code.evpg.render()
        return
    if code.physics.win
        code.evpg.set("win") unless M(code.evpg.text).bool()
        code.evpg.render()
        return
    else code.physics.render()

code.animate(update, render)

window.Code = Code
