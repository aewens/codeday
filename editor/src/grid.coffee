define ["jquery", "mods/dom"], ($, Dom) ->
    class Grid
        constructor: (editor) ->
            @editor = editor
            @$editor = $(@editor)
            
            # Last espace value
            @lx = 0
            @ly = 0
            
            # Current position
            @cx = 0
            @cy = 0
            
            # Hard coded numbers
            @tw = 10 # because font-size = 16px
            @th = 25 # because font-size = 16px
            
            # Info for espace navigation
            @ew = @$editor.width()
            @eh = @$editor.height()
            @ux = Math.floor(@ew / @tw)
            @uy = Math.floor(@eh / @th)
            @capX = 0
            @capY = @ux * @uy
            
            # Initialize first eline
            # @make("div", editor)
            #     .width(@ux * @tw)  
            #     .height(@th) 
            #     .addClass("eline")
            #     .attr("line", @ly)
            #     .css({top: (@ly * @uy), left: (@lx * @ux)})
            #     .append(@espace()) # Initialize first espace
            @espaces() # Initialize first espace
                
            # Create cursor
            @cursor = {}
            @cursor.on = true
            @cursor.element = null
            @cursor.style = 0 # 0: whole, 1: under, 2: side
            @curse() # Initialize cursor
            @
        make: (here, there) ->
            $((new Dom).create(here).into(there).element)
        curse: ->
            if @cursor.element is null
                @cursor.element = $(@$editor.children()[0]).addClass("cursor")
                @fg = @cursor.fg = @cursor.element.css("color")
                @bg = @cursor.bg = @cursor.element.css("background-color")
                blink = ->
                    switch @cursor.style
                        when 0
                            fg = @cursor.fg
                            bg = @cursor.bg
                            @cursor.element.css("background", fg)
                            @cursor.element.css("color", bg)
                            @cursor.fg = bg
                            @cursor.bg = fg
                        else
                            fg = @cursor.fg
                            bg = @cursor.bg
                            @cursor.element.css("background", fg)
                            @cursor.element.css("color", bg)
                            @cursor.fg = bg
                            @cursor.bg = fg
                    @cursor.on = !@cursor.on
                setInterval(blink.bind(@), 500)
            else
                @cursor.element.removeClass("cursor")
                @cursor.element = $(".espace[x='#{@cx}'][y='#{@cy}']")
                                    .addClass("cursor")
        espaces: ->
            es = [0..(@ux*@uy)-1]
            for e in es
                @espace()
                if (e % @ux) is @ux - 1
                    @lx = 0
                    @ly = @ly + 1
                else
                    @lx = @lx + 1
            @cx = 0
            @cy = 0
        espace: ->
            @make("div", editor)
                .width(10)  # because font-size = 16px
                .height(25) # because font-size = 16px
                .addClass("espace")
                .attr("x", @lx)
                .attr("y", @ly)
                .css({top: (@ly * @uy), left: (@lx * @tw)})
        type: (pos, val) ->
            x = pos % @ux
            y = Math.floor(pos / @ux)
            @cursor.element.text(val)
            @cursor.element.css("color", @fg)
            @cursor.element.css("background", @bg)
            # if y < @capX
                
            # if y > @capY 
            if x > @ux
                @lx = @cx = 0
                @ly = @cy = y
                @espace()
                @curse()
            else
                @lx = @cx = x
                @ly = @cy = y
                @espace()
                @curse()
                
    
    return Grid
