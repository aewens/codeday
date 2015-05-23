Workflow
===

If you choose to not use the given index.html, 
do the following:

* Include helper.js and main.js with require.js
```html
    <script src="bin/helper.js"></script>
    <script data-main="bin/main" src="vendor/require.js"></script>
```

Most of the files you will work with will be in `src`. 
The file that everything runs from is `main.coffee`.

Engine::Two currently comes packaged with the 
automation script Pappai to make working with canvas 
more pain-free using Black Magic™.

Pappai comes with the Init function to easily load 
in the canvas element and setting the stage for you 
while also supplying the 2D context as the return 
value. To utilize this simply run:
```coffee
    ctx = Pappai.Init(width, height, theater)
    canvas = ctx.canvas
```
In this case, theater is a boolean flag that when set 
to true will override the width and height parameters 
and will instead make use of the whole screen of the 
browser. This is useful so that an if check can be 
used to determine if theater mode should be used, 
and can default to the pre-defined width and height 
if the check does not pass.
