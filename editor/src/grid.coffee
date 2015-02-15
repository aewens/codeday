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
            @capT = 0
            @capB = @ux * @uy
            
            @cells = []
            
            @gen(@ux * @uy, 0, 0) # Initialize first espace
                
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
                @cursor.element = $(@cells[0].select).addClass("cursor")
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
                @cursor.element = $(@get(@cx, @cy).select).addClass("cursor")
        gen: (to, endX, endY) ->
            cs = [0..to-1]
            for c in cs
                cell = @cell()
                cell.render()
                @cells.push cell
                if (c % @ux) is @ux - 1
                    @lx = 0
                    @ly = @ly + 1
                else
                    @lx = @lx + 1
            @cx = endX
            @cy = endY
        get: (x, y) ->
            ret = null
            for c, cell of @cells
                if cell.x is x and y is cell.y
                    ret = cell
            ret
        cell: ->
            a = this
            return {
                empty: true
                x: a.lx
                y: a.ly
                cursor: false
                select: ".cell[x='#{a.lx}'][y='#{a.ly}']"
                render: ->
                    a.make("div", editor)
                        .width(10)  # because font-size = 16px
                        .height(25) # because font-size = 16px
                        .addClass("cell")
                        .attr("x", a.lx)
                        .attr("y", a.ly)
                        .css({top: (a.ly * a.uy), left: (a.lx * a.tw)})
            }
        move: (pos) ->
            x = pos % @ux
            y = Math.floor(pos / @ux)
            if y > @ly
                @cell(@ux, 0, @ly + 1)
                
            @cx = x
            @cy = y
            @curse()
        type: (pos, val) ->
            x = pos % @ux
            y = Math.floor(pos / @ux)
            @cursor.element.text(val)
            @cursor.element.css("color", @fg)
            @cursor.element.css("background", @bg)
            if y < @capX
                @capT = @capT - @ux
                @capB = @capB - @capT
                @$editor.css("margin-top", @capT)
                @cx = x
                # @cy = 
            if y > @capB
                @gen(@ux, 0, @ly + 1)
                @capT = @ux
                @capB = @capB + @capT
                @$editor.css("margin-top", -@capT)
            if x > @ux
                @lx = @cx = 0
                @ly = @cy = y
                @cell()
            else
                @lx = @cx = x
                @ly = @cy = y
                @cell()
            @curse()
            
    return Grid
