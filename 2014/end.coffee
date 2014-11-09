class End
    constructor: (root, canvas, ctx) ->
        @root = root
        @canvas = canvas
        @ctx = ctx
        @once = false
        @reset = false
    
    update: ->
        unless @once
            endDiv = document.createElement("div")
            endDiv.id = "end"
            endText = document.createTextNode("Game Over")
            @root.appendChild(endDiv).appendChild(endText)
            @once = true
            document.addEventListener "click", (e) ->
                window.location.reload(true)
        
    render: ->
        @ctx.fillStyle = "#000"
        @ctx.fillRect(0, 0, @canvas.width, @canvas.height)
        
    
window.End = End
