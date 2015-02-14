define ["jquery"], ($) ->
    class Layout
        constructor: ->
            console.log "Setting elements in place..."
            nav     = $("nav")
            header  = $("header")
            aside   = $("aside")
            section = $("section")
            footer  = $("footer")
            width   = w = window.innerWidth
            height  = h = window.innerHeight
            
            # header
            height = height - 24
            header.width(width)
            header.height(24)
            width = width - 64
            logo = header.children()[0]
            $(logo).width(64)
            $(logo).height(24)
            $(logo).css("line-height", "24px")
            
            # nav
            nav.width(width)
            nav.height(24)
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
            aside.width(width * ascale)
            aside.height(height)
            width = width - (width * ascale)
            
            # section
            height = height - 24
            section.width(width)
            section.height(height)
            textarea = section.children()[0]
            editor   = section.children()[1]
            
            # footer
            footer.width(width)
            footer.height(24)
            footer.css("left", w * ascale)
            ftext = footer.children()[0]
            $(ftext).css("margin", "8px")
            
            return editor
            
        
    return Layout
    
    
# find = (elem) ->
#     element = document.querySelectorAll(elem)[0]
#     return null if element is undefined
#     # Object
#     ret =
#         size: (w, h) ->
#             @element.style.width = "#{w}px"
#             @element.style.height = "#{h}px"
#         set: (k, v) ->
#             @element.style[k] = v
#             
#     # /Object
#     if element.length == 1
#         ret.element = element[0]
#         return ret
#     else
#         ret.element = element
#         return ret
