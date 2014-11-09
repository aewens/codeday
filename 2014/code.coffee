class Code
    constructor: ->
        @root = document.querySelector("#wrapper")
        canvas  = document.createElement("canvas")
        cwords  = "Your browser is bad and you should feel bad"
        ctext   = document.createTextNode cwords
        
        @root.appendChild(canvas).appendChild(ctext)
            
        @canvas = canvas
        @ctx    = @canvas.getContext("2d")
        
        @dimensions(@root)
        
        self = @
        window.addEventListener "resize", (e) ->
            self.dimensions(self.root)
        
    dimensions: (root) ->
        # w = root.offsetWidth
        # h = root.offsetHeight
        w = parseInt window.getComputedStyle(root).width
        h = parseInt window.getComputedStyle(root).height
        console.log w
        r0 = 32
        r1 = 9
        r2 = r0 * r1

        x = max(w,h)
        y = max(r0,r1)

        # @unit = pow(2,((floor(log(floor(x/y))/log(2)))))
        @unit = floor(x/y)
        
        console.log @unit
        
        @canvas.width  = @unit * r0
        @canvas.height = @unit * r1
        
        m0 = (h - @canvas.height) / 2
        m1 = (w - @canvas.width)  / 2
        
        @canvas.style.margin = "#{m0}px #{m1}px"
        
    inputs: ->
        @keyState = {}
        self = @
        document.addEventListener "keydown", (e) -> 
            self.keyState[e.keyCode] = true
        document.addEventListener "keyup", (e) -> 
            self.keyState[e.keyCode] = false
        
    animate: (update, render) ->
        self = @
        rf = (x,y) -> window.requestAnimationFrame(x,y)
        l = ->
            update()
            render()
            rf l, self.canvas
        rf l, @canvas
        
code = new Code()
code.inputs()

sy = code.canvas.height - code.unit * 2

level = new Level(Level0, code.unit)
darkness = new Box(0, 0, code.canvas.width, 
                code.canvas.height, new Color(0,0,0,0.5))
mob1 = new Mob(code.unit * 0.5, sy, code.unit)
player = new Player(code.unit * 2, sy, code.unit)
end = new End(code.root, code.canvas, code.ctx)
physics = new Physics(code, level, player, darkness, end)

physics.addMobs(mob1)

update = ->
    physics.update()

render = ->
    physics.render()

code.animate(update, render)

# box1 = new Box(100,100,100,100, new Color(0, 100, 50))
# box2 = new Box(250,100,100,100, new Color(120, 100, 50))
# box3 = new Box(400,100,100,100, new Color(240, 100, 50))
# move = 1
# 
# v0 = new Vector2(10,15)
# v1 = new Vector2(4,5)
# console.log v0.set(20,20)
# console.log v0.dist()
# 
# code.animate ->
#     code.ctx.clearRect(0, 0, code.canvas.width, code.canvas.height)
#     box2.move(move, 0)
#     if box2.intersects(box1) or box2.intersects(box3)
#         move = -move
#         box2.move(move, 0)
#     box1.render(code.ctx, "#f00")
#     box2.render(code.ctx, "#0f0")
#     box3.render(code.ctx, "#00f")

window.Code = Code
