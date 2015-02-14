define ["jquery"], ($) ->
    class Layout
        constructor: (root) ->
            @root = $(root)
            unless @root is []
                console.log "Root is: (#{@root.element})"
            else
                console.log "Error 00: `root` is null"
        sizes: ->
            nav     = $("nav")
            aside   = $("aside")
            header  = $("header")
            section = $("section")
            footer  = $("footer")
            width   = window.innerWidth
            height  = window.innerHeight
            
            # nav
            height = height - 24
            nav.width(width)
            nav.height(24)
            # To center text
            nav.children().each ->
                self = this
                $(self).css("line-height", "24px")
                $(self).each ->
                    $(this).css("line-height", "24px")
                
            
        
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
