#!/bin/sh
convert -size 1080x1350 \
    xc:#cef \
    -fx 'u * (cos(i*0.007) * (sin(j*50)-abs(sin(j*50))))' \
    -swirl '-90' -rotate 180 \
    -crop +100+0 -background black -extent +100+0 \
    "${0##*/}.png"
