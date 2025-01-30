#!/usr/bin/env python3
import random
import numpy as np
import sys
from PIL import Image, ImageDraw, ImageFont

random.seed(404)
fontpath = "/usr/share/fonts/truetype/freefont/FreeMono.ttf"

def main():
    img = Image.new("RGB", (2500,)*2, 0x0)
    draw = ImageDraw.Draw(img)
    pos = np.array((img.size[0] / 2, img.size[1]))
    vel = np.array([0.0,0.0])
    font = ImageFont.truetype(fontpath, 50)
    mul = 6
    crash = 2.0 * mul
    gravity = np.array([0,0.3*mul])
    helium = np.array([0,-0.8*mul])
    positions = []
    for i in range(500):
        wind = np.array([random.gauss(0, 3*mul), random.gauss(0,1*mul)])
        acceleration = gravity + helium + wind
        if pos[0] < 0: acceleration[0] += abs(pos[0]*crash)
        if pos[0] > img.size[0]: acceleration[0] -= abs((img.size[0]-pos[0])*crash)
        if pos[1] < 0: acceleration[1] += abs(pos[1]*crash)
        if pos[1] > img.size[1]: acceleration[1] -= abs((img.size[1]-pos[1])*crash)
        vel += acceleration
        vel = np.clip(vel, -10*mul, 10*mul)
        pos += vel
        positions.append(pos.copy())
        draw.line([tuple(pos), tuple(pos-np.array(img.size))], 0xfafafa)
    for i in range(len(positions)):
        if i % 2 == 0: continue
        draw.text(positions[i], "+", fill=0x00ff00, font=font)
    draw.text([img.size[0]*.05,img.size[1]*.6], "/square dup mul def", "white", ImageFont.truetype(fontpath, 200))
    img.save(sys.argv[1])

if __name__ == '__main__':
    main()
