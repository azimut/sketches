#!/usr/bin/env python3
import random
import numpy as np
import sys
from PIL import Image, ImageDraw, ImageFont

random.seed(409)
fontpath = "/usr/share/fonts/truetype/freefont/FreeMono.ttf"
size = 2500

class Mover:
    def __init__(self, pos, mass):
        self.pos = np.array(pos)
        self.vel = np.array([0.0,0.0])
        self.mass = mass

def randpos():
    return [random.random()*size,random.random()*size]

def main():
    img = Image.new("RGB", (size,)*2, 0x0)
    draw = ImageDraw.Draw(img)
    font = ImageFont.truetype(fontpath, 50)
    mul = 6
    gravity = np.array([0,0.3*mul])
    helium = np.array([0,-0.8*mul])
    bodies = [Mover(randpos(),1), Mover(randpos(),3)]
    for i in range(500):
        for body in bodies:
            wind = np.array([random.gauss(0, 3*mul), random.gauss(0,1*mul)])
            if body.pos[0] < 0: body.pos[0] = 0; body.vel[0] *= -1
            if body.pos[0] > img.size[0]: body.pos[0] = img.size[0]; body.vel[0] *= -1
            if body.pos[1] < 0: body.pos[1] = 0; body.vel[1] *= -1
            if body.pos[1] > img.size[1]: body.pos[1] = img.size[1]; body.vel[1] *= -1
            acceleration = (gravity + helium + wind) / body.mass
            body.vel += acceleration
            body.vel = np.clip(body.vel, -10*mul, 10*mul)
            body.pos += body.vel
            draw.line([tuple(body.pos), tuple(body.pos-np.array(img.size))], 0xfafafa)
    draw.text([img.size[0]*.16,img.size[1]*.43], "def square(x):\n  return x*x", "white", ImageFont.truetype(fontpath, 200))
    img.save(sys.argv[1])

if __name__ == '__main__':
    main()
