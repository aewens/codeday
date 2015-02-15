define ["jquery"], ($) ->
    class Layout
        constructor: ->
            console.log "Setting elements in place..."
            dialog  = $("#dialog")
            header  = $("header")
            nav     = $("nav")
            aside   = $("aside")
            section = $("section")
            footer  = $("footer")
            width   = w = window.innerWidth
            height  = h = window.innerHeight
            
            # dialog
            dwidth = width * 0.5
            dheight = 32
            dialog.width(dwidth).height(dheight).css({
                top: height / 2
                marginTop: -(dheight / 2)
                left: width / 2
                marginLeft: -(dwidth / 2)
            })
            
            # header
            height = height - 24
            header.width(width).height(24)
            width = width - 64
            logo = header.children()[0]
            $(logo).width(64).height(24).css("line-height", "24px")
            
            # nav
            nav.width(width).height(24)
            # To center text
            nav.children().each ->
                self = this
                $(self).css("line-height", "24px")
                $(self).children().each ->
                    $(this).css("line-height", "24px")
                    $(this).width(64)
            width = w
            # aside
            ascale = 0.15
            aside.width(width * ascale).height(height)
            width = width - (width * ascale)
            
            # section
            height = height - 24
            section.width(width).height(height)
            width = width - 24
            lines = $(section.children()[0]).width(24).height(height)
            textarea = $(section.children()[1]).css({
                width: width
                height: height
                left: 24
            })
                        
            
            # footer
            width = w
            footer.width(width).height(24).css("left", w * ascale)
            ftext = footer.children()[0]
            $(ftext).css("margin", "8px")
            
            return $(section.children()[1])
        resize: ->
            console.log "Setting elements in place..."
            dialog  = $("#dialog")
            header  = $("header")
            nav     = $("nav")
            aside   = $("aside")
            section = $("section")
            footer  = $("footer")
            width   = w = window.innerWidth
            height  = h = window.innerHeight
            
            # dialog
            dwidth = width * 0.5
            dheight = 32
            dialog.width(dwidth).height(dheight).css({
                top: height / 2
                marginTop: -(dheight / 2)
                left: width / 2
                marginLeft: -(dwidth / 2)
            })
            
            # header
            height = height - 24
            header.width(width).height(24)
            width = width - 64
            logo = header.children()[0]
            $(logo).width(64).height(24).css("line-height", "24px")
            
            # nav
            nav.width(width).height(24)
            # To center text
            nav.children().each ->
                self = this
                $(self).css("line-height", "24px")
                $(self).children().each ->
                    $(this).css("line-height", "24px")
                    $(this).width(64)
            width = w
            # aside
            ascale = 0.15
            aside.width(width * ascale).height(height)
            width = width - (width * ascale)
            
            # section
            height = height - 24
            section.width(width).height(height)
            width = width - 24
            lines = $(section.children()[0]).width(24).height(height)
            textarea = $(section.children()[1]).css({
                width: width
                height: height
                left: 24
            })
                        
            
            # footer
            width = w
            footer.width(width).height(24).css("left", w * ascale)
            ftext = footer.children()[0]
            $(ftext).css("margin", "8px")
            
            return $(section.children()[1])
            
    return Layout
