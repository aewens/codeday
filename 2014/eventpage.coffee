class EventPage
    constructor: (code, ev) ->
        @root = code.root
        @canvas = code.canvas
        @ctx = code.ctx
        @once = false
        @reset = false
        @events =
            "end": "Game Over"
            "win": "You Win!"
        
    set: (ev) -> 
        @event = ev
        @text = @events[ev]
        console.log @text
    
    update: ->
        unless @once
            epDiv = document.createElement("div")
            epDiv.id = "evpg"
            epText = document.createTextNode(@text)
            @root.appendChild(epDiv).appendChild(epText)
            @once = true
            document.addEventListener "click", (e) ->
                if @event is "end"
                    window.location.reload(true)
        
    render: ->
        @ctx.fillStyle = "#000"
        @ctx.fillRect(0, 0, @canvas.width, @canvas.height)
        
    
window.EventPage = EventPage
