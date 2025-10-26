#!/bin/bash
set -xe
INPUT='/home/sendai/Capri - Pantera [j4jqw1cS4mk].mp4' # 160x128
ffmpeg -nostdin -hide_banner -y \
    -ss 00:00:44.3 -t 2.3 -i "${INPUT}" \
    -ss 00:01:04.8 -t 1.2 -i "${INPUT}" \
    -ss 00:01:08.3 -t 1.2 -i "${INPUT}" \
    -ss 00:01:01.2 -t 3.5 -i "${INPUT}" \
    -ss 00:01:07 -t 1.3 -i "${INPUT}" \
    -ss 00:01:09.6 -t 4.5 -i "${INPUT}" \
    -ss 00:01:14.2 -t 1 -i "${INPUT}" \
    -f lavfi -i "color=black:180x320" \
    -an \
    -lavfi "[3][4][5]concat=3[frag1];
            [0]hflip[0flip];
            [0flip][1][2][6]concat=4,setpts=1.3*PTS[frag2];
            [frag1][frag2]vstack[scene];
            [7][scene]overlay=x=(W/2)-(w/2):y=(H/2)-(h/2):shortest=true" \
    pantera.mp4
mpv -loop pantera.mp4
