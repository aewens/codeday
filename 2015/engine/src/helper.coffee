window.random = Math.random
window.round  = Math.round
window.floor  = Math.floor
window.atan2  = Math.atan2
window.ceil   = Math.ceil
window.atan   = Math.atan
window.asin   = Math.asin
window.acos   = Math.acos
window.sqrt   = Math.sqrt
window.log    = Math.log
window.sin    = Math.sin
window.cos    = Math.cos
window.abs    = Math.abs
window.max    = Math.max
window.min    = Math.min
window.pow    = Math.pow
window.tau    = Math.PI * 2
window.exp    = Math.exp
window.pi     = Math.PI
window.ln     = Math.log
window.E      = Math.E

window.sqre = (x) -> Math.pow(x, 2)
window.clamp = (val, min, max) ->
    Math.min(Math.max(val, min), max)
