define ->
    class Dom
        constructor: ->
        create: (element) ->
            @element = document.createElement(element)
            if @isElement(@element)
                return @
            else
                null
        isElement: (element) ->
            element instanceof HTMLElement
        into: (element) ->
            unless @isElement(element)
                console.log "Error #001: (#{element})"
                return
            element.appendChild(@element)
            @
        add: (dom) ->
            return unless dom
            unless @isElement(dom.element)
                console.log "Error #002: (#{dom.element})"
                return
            @element.appendChild(dom.element)
            @
        find: (elem) ->
            element = document.querySelectorAll(elem)[0]
            return null if element is undefined
            if element.length == 1
                @element = element[0]
            else
                @element = element
            @
            
    return Dom
