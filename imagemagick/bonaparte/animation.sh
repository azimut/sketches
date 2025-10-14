#!/bin/bash
set -e
COVER=a1499432218_10.jpg
COLOR="$(convert "${COVER}" -format '%[hex:p{1,1}]' info:)"
ffmpeg -y \
    -loop 1 -i "${COVER}" \
    -f lavfi -i "color=0x${COLOR^^}:1080x1920" \
    -lavfi "[0]rotate=angle='-mod(2*PI/10*t,2*PI)':fillcolor=0x${COLOR^^}[rotated];
            [1][rotated]overlay=(W/2)-(w/2):(H/2)-(h/2)" \
    -t 10 out.mp4
mpv out.mp4
