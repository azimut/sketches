#!/bin/sh
convert -size 1080x1350 \
    xc:#cef \
    -fx '(u-sin((j/w))) + (cos(i*.1)*sin(j*.1))' \
    -swirl 180 \
    "${0##*/}.png"
