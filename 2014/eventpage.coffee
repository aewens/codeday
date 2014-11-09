class EventPage
    constructor: (code, ev) ->
        @code = code
        @root = code.root
        @canvas = code.canvas
        @ctx = code.ctx
        @once = false
        @reset = false
        @run = false
        @events =
            "end": "Game Over"
            "win": "You Win!"
            "done": "You got the sun, you win the game!"
        
    set: (ev) -> 
        @event = ev
        @text = @events[ev]
        console.log @text
        
    done: ->
        @set("done")
        @update()
        @render()
    
    update: ->
        unless @once
            epDiv = document.createElement("div")
            epDiv.id = "evpg"
            epText = document.createTextNode(@text)
            @root.appendChild(epDiv).appendChild(epText)
            @once = true
            self = @
            document.addEventListener "click", (e) ->
                if self.event is "end" or self.event is "done"
                    window.location.replace(window.location.pathname)
                if self.event is "win"
                    epDiv.remove()
                    level = self.code.nextLevel()
                    self.code.resetLevel() 
                    
        
    render: ->
        @ctx.fillStyle = "#000"
        @ctx.fillRect(0, 0, @canvas.width, @canvas.height)
        
    
window.EventPage = EventPage
