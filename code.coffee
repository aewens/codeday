class Code
    constructor: ->
        wrapper = document.querySelector("#wrapper")
        canvas  = document.createElement("canvas")
        cwords  = "Your browser is bad and you should feel bad"
        ctext   = document.createTextNode cwords
        
        wrapper.appendChild(canvas).appendChild(ctext)
        
        canvas.width = window.innerWidth
        canvas.height = window.innerHeight
        
        window.addEventListener "resize", (e) ->
            canvas.width  = window.innerWidth
            canvas.height = window.innerHeight
            
        @canvas = canvas
        @ctx    = @canvas.getContext("2d")
        
    animate: (cycle) ->
        rf = (x,y) -> window.requestAnimationFrame(x,y)
        self = @
        l = ->
            cycle()
            rf l, self.canvas
        rf l, @canvas
        
code = new Code()
box1 = new Box(100,100,100,100)
box2 = new Box(250,100,100,100)
box3 = new Box(400,100,100,100)
move = 1

v2 = new Vector2(1,2)
console.log v2.set(3,4)

code.animate ->
    code.ctx.clearRect(0, 0, code.canvas.width, code.canvas.height)
    box2.move(move, 0)
    if box2.intersects(box1) or box2.intersects(box3)
        move = -move
        box2.move(move, 0)
    box1.render(code.ctx, "#f00")
    box2.render(code.ctx, "#0f0")
    box3.render(code.ctx, "#00f")

window.Code = Code
