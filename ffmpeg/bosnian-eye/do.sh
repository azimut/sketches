#!/bin/bash
set -ex

FFMPEG="${HOME}/Downloads/ffmpeg-master-latest-linux64-gpl/bin/ffmpeg"
VIDEO="${HOME}/Videos/music/Bosnian Rainbows - The Eye Fell In Love - 2012-09-12 Helsinki [xduSqBLJHEE].mkv"

vf() { m4 ../vf.m4 - <<<"$1"; }

$FFMPEG -y -ss 00:04:30 -t 25 -i "${VIDEO}" \
    -lavfi "$(
        vf "[0]
        crop=
           w='ih/(16/9)':
           x='if(lt(t,6),
                 iw/2,
                 if(lt(t,10),
                    iw/2 -       lerp(0,400,min(1,(t-6)/4)),
                    iw/2 - 400 + lerp(0,450,min(1,(t-10)/3))) )'"
    )" \
    -c:a copy \
    out.mp4

$FFMPEG -y -i out.mp4 -loop 1 -i foo.png \
    -lavfi "$(vf "
       [1:v]
           format=rgba,
           rotate=
                c=none:
                ow='hypot(iw,ih)':
                oh='hypot(ih,iw)':
                a='if(lt(t,26.5),
                      0,
                      lerp(0,PI*4,min(1,((t-26.5)/20))))',
           fade=t=in:  st=13.5: d=3: alpha=1,
           fade=t=out: st=36:   d=3: alpha=1
       [i];
       [0:v][i]
           overlay=0:0")" \
    -shortest \
    card.mp4

mpv -loop 0 -volume 0 -ss 00:00:26 card.mp4
