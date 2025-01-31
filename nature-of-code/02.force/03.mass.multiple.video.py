#!/usr/bin/env python3
import os
import itertools
import cv2
import random
import numpy as np
import sys
from PIL import Image, ImageDraw, ImageFont

random.seed(409)
fontpath = "/usr/share/fonts/truetype/freefont/FreeMono.ttf"
size = 500
fourcc = cv2.VideoWriter_fourcc(*'avc1')
video = cv2.VideoWriter("f00.mp4", fourcc, 30, (size,)*2)

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
    font = ImageFont.truetype(fontpath, 25)
    mul = 2
    gravity = np.array([0,0.3*mul])
    helium = np.array([0,-0.8*mul])
    bodies = [ body() for body in itertools.repeat(lambda: Mover(randpos(), random.randint(1, 6)), 10)]
    for i in range(200):
        for b in range(len(bodies)):
            body = bodies[b]
            wind = np.array([random.gauss(0, 3*mul), random.gauss(0,1*mul)])
            if body.pos[0] < 10: body.pos[0] = 10; body.vel[0] *= -1
            if body.pos[0] > img.size[0]: body.pos[0] = img.size[0]; body.vel[0] *= -1
            if body.pos[1] < 10: body.pos[1] = 10; body.vel[1] *= -1
            if body.pos[1] > img.size[1]: body.pos[1] = img.size[1]; body.vel[1] *= -1
            acceleration = (gravity + helium + wind) / body.mass
            body.vel += acceleration
            body.vel = np.clip(body.vel, -10*mul, 10*mul)
            body.pos += body.vel
            draw.circle(tuple(body.pos + [8,11]), body.mass*4, 0xaaaaaa, 0xaaaaaa)
            draw.text(tuple(body.pos), str(body.mass), 0, font)
        draw.text([img.size[0]*.2,img.size[1]*.43], "[0]reverse[r]\n[0][r]concat,loop", "cyan", ImageFont.truetype(fontpath, 30))
        imtemp = img.copy()
        video.write(cv2.cvtColor(np.array(imtemp), cv2.COLOR_RGB2BGR))
        draw.rectangle([(0,0),img.size],0) # clear
    video.release()
    looper = '[0]reverse[r];[0][r]concat,loop'
    gif = 'fps=20,scale=320:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse'
    os.system(f"ffmpeg -y -i f00.mp4 -filter_complex '{looper},{gif}' {sys.argv[1]} 2>/dev/null")
    os.remove("f00.mp4")

if __name__ == '__main__':
    main()
