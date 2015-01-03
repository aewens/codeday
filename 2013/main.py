#!/usr/bin/env python

import pyglet, os, sys, hashlib, random, uuid
from pyglet.gl import *
from pyglet.window import key
from random import randint

__game__    = "Lost in Data"
__author__  = "aewens"

# only use one file, shift seed each rotation

block_size  = 20
w_width     = block_size * 4 * 10
w_height    = block_size * 3 * 10
window      = pyglet.window.Window(w_width,w_height)
keys        = key.KeyStateHandler()
fps         = pyglet.clock.ClockDisplay()
gen_seed    = randint(0,255)#filepath=sys.argv[1]
p_color     = "ff0000"
p_health    = 1
p_points    = 0

if len(sys.argv) > 2:
    p_color = sys.argv[2]
window.push_handlers(keys)

nums = [str(n) for n in range(0,10)]
char = [chr(x) for x in range(ord('a'), ord('f') + 1)]
uses = sum([nums,char],[])

def file_get_contents(filename):
    with open(filename) as f:
        return f.read()

def file_get_size(filename):
    return os.path.getsize(filename)

def if_prime(p):
    return all(p % div != 0 for div in range(2, p))

def useed(seed):
    see,d  = seed[:-2],seed[-2:]
    unseed  = [x for x in see]
    seeds   = [(int(n,16)%8) for n in unseed]
    a,b     = [int(e,16) for e in list(d)]
    one_ups = 0
    if if_prime(a):
        one_ups = one_ups + 1
        if if_prime(b):
            one_ups = one_ups + 1
    return (seeds, one_ups)

def temp_random_color():
    rand = ""
    for x in range(0,7):
        rand = rand + uses[randint(0,15)]
    return rand

def temp_fill(grid):
    h = len(grid)
    w = len(grid[0])
    #pixels = grid
    for y in range(0,h):
        for x in range(0,w):
            draw_block([x,y], hex2rgb(temp_random_color()))

def back(hex):
    r,g,b  = hex2rgb(hex)
    rgba = (r/255.0,g/255.0,b/255.0,1)
    return rgba

def hex2rgb(hex):
    rgb = []
    rgb.append(int(hex[:2],16))
    rgb.append(int(hex[2:4],16))
    rgb.append(int(hex[4:],16))
    return rgb

px, py  = block_size,block_size
pc      = []
def draw_block(pos=[0,0],rgb=[0,0,0],size=block_size,cache=False):
    x, y    = pos
    r, g, b = rgb
    x       = x * size
    y       = y * size
    coords  = (0 + x, 0 + y,
                block_size + x, 0 + y,
                block_size + x, block_size + y,
                0 + x, block_size + y)

    pyglet.graphics.draw_indexed(4, pyglet.gl.GL_TRIANGLES,
        [0, 1, 2, 0, 2, 3],
        ('v2i', coords),
        ('c3B', (r, g, b,
                 r, g, b,
                 r, g, b,
                 r, g, b))
    )

    if cache: return coords

compare = lambda a,b: len(a)==len(b) and len(a)==sum([1 for i,j in zip(a,b) if i==j])

def collide(fx,fy,i=-1):
    global total
    global cx,cy
    global px,py
    global pc,mc
    global p_health
    if i < 0:
        cx = px
        cy = py
    else:
        cx = mx[i]
        cy = my[i]

    for c in mc:
        if compare(pc,c):
            p_health = p_health - 1

    grid = [[x*block_size,y*block_size] for x,y in total]
    if not [fx,fy] in grid:
        return [fx, fy]
    else:
        xt = [x[0] for x in grid]
        xx = [x * block_size for x in xt]
        yt = [y[0] for y in grid]
        yy = [y * block_size for y in yt]
        if fx in xx:
            if fy in yy:
                return [cx, cy]
            else:
                return [cx,fy]
        else:
            if fy in yy:
                return [fx,cy]
            else:
                return [cx,cy]

def generate_grid():
    grid    = {}
    width   = w_width  / block_size
    height  = w_height / block_size
    for h in range(0, height):
        grid[h] = {}
        for w in range(0, width):
            grid[h][w] = (hex2rgb("000000"))
    return grid

def build_wall(grid):
    h = len(grid)
    w = len(grid[0])
    border = []
    for y in range(0,30):
        for x in range(0,40):
            if y is 0 or y is h-1:
                color = "ffffff"
                draw_block([x,y], hex2rgb(color))
                border.append([x,y])
            else:
                if x is 0 or x is w-1:
                    color = "ffffff"
                    draw_block([x,y], hex2rgb(color))
                    border.append([x,y])
    return border

def spots():
    n = 4
    x = [i*n for i in range(1,(40/n))]
    y = [i*n for i in range(1,(30/n))]
    r = []
    for b in y:
        for a in x:
            r.append([a,b])
    return r

def plant(spots,seeds):
    r_spots = []
    s       = 0
    for spot in spots:
        if not seeds[s] % 7 is 0:
            r_spots.append(spot)
        s = s + 1
    return r_spots

def branches():
    return [int("1234"[randint(0,3)])]

def grow(spots):
    s = 0
    walls = []
    for spot in spots:
        dirs  = branches()
        s     = s + 1
        x,y   = spot[0],spot[1]
        remap = {1:-1,2:-1,3:1,4:1}
        for i in range(0,len(dirs)):
            m = remap[dirs[i]]
            for j in range(0,5):
                if dirs[i] % 2 == 0:
                    walls.append([x+(m*j),y])
                else:
                    walls.append([x,y+(m*j)])
    return walls

def player():
    global px,py, pc
    pc = draw_block([px, py],hex2rgb(p_color),1,True)

pyglet.gl.glClearColor(*back("000000"))

grid           = generate_grid()
border         = build_wall(grid)
seed           = str(gen_seed) #file_get_contents(gen_seed)
seeds, one_ups = useed(hashlib.sha512(seed).hexdigest())
bases          = plant(spots(),seeds)
walls          = grow(bases)
total          = sum([bases, walls, border],[])
time           = 0
not_moved      = 0

def mob_amount(filesize):
    return len(str(filesize))

mx,my,mc = [],[],[]
def mob_gen(amount):
    mobs = []
    i = 0
    for m in range(0,amount):
        r = randint(0,len(bases)-1)
        mx.append(bases[r][0] * block_size + block_size)
        my.append(bases[r][1] * block_size + (block_size * 2))
        mobs.append([mx, my, i])
        i = i + 1
    return mobs

def mob(x,y,i):
    global mx,my,mc
    x       = mx[i]
    y       = my[i]
    rgb     = hex2rgb(p_color)
    r,g,b   = rgb
    r       = 255 - r
    g       = 255 - g
    b       = 255 - b
    mc.append(draw_block([x, y],(r,g,b),1,True))

# mob_count = mob_amount(file_get_size(filepath))
mob_list  = mob_gen(randint(1,10) * 2)

def rebuild(new_seed):
    global grid, border, seed, seeds, one_ups, bases, walls, total, time, mob_list
    grid           = generate_grid()
    border         = build_wall(grid)
    seed           = str(new_seed) #file_get_contents(filepath)
    seeds, one_ups = useed(hashlib.sha512(seed).hexdigest())
    bases          = plant(spots(),seeds)
    walls          = grow(bases)
    total          = sum([bases, walls, border],[])
    time           = 0
    not_moved      = 0
    mob_list       = mob_gen(randint(1,10) * 2)

def tiles(concat):
    global total
    return total

def game_over(points):
    plural = ""
    if points != 1: plural = "s"
    print "You died with: %s point%s" % (points, plural)

def update(dt):
    global px,py,time,p_health,p_points,not_moved
    b     = block_size
    limit = 120
    time  = time + 1
    if not_moved >= limit/2 - 20:
        p_health = p_health - 1

    if time == limit:
        p_points = p_points + 1
        rebuild(randint(0,255))

    if time % 2 is 0:
        cx,cy = px, py
        if keys[key.W]: px, py = collide(px + 0, py + b)
        if keys[key.S]: px, py = collide(px + 0, py - b)
        if keys[key.D]: px, py = collide(px + b, py + 0)
        if keys[key.A]: px, py = collide(px - b, py + 0)
        if cx == px and cy == py:
            not_moved = not_moved + 1

    if keys[key.ESCAPE]:
        game_over(p_points)
        sys.exit()

    i = 0
    if time % 10 is 0:
        for m in mob_list:
            dirs = [-1,0,1]
            b = block_size
            f = [randint(0,2),randint(0,2)]
            g = [1,1]
            if f[1] < 0:
                g[1] = 2
            x, y = collide(mx[i]  + (dirs[f[0]]  * b), my[i]  + (dirs[f[1]] * b),i)
            mx[i] = x
            my[i] = y
            i = i + 1

def draw(show=False):
    window.clear()
    for t in tiles(total):
        draw_block([t[0],t[1]],hex2rgb("ffffff"))
    player()
    i = 0
    for m in mob_list:
        x = mx[i]
        y = my[i]
        mob(x,y,i)
        i = i + 1
    if show: fps.draw()

pyglet.clock.schedule_interval(update, 1/60.0)

while not window.has_exit and p_health > 0:
    dt = pyglet.clock.tick()
    update(dt)
    window.dispatch_events()
    window.clear()
    draw()
    window.flip()
else:
    game_over(p_points)

















        
   
