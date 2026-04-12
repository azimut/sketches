#!/bin/bash
set -ex

FFMPEG="${HOME}/Downloads/ffmpeg-master-latest-linux64-gpl/bin/ffmpeg"
VIDEO="${HOME}/Videos/music/Bosnian Rainbows - The Eye Fell In Love - 2012-09-12 Helsinki [xduSqBLJHEE].mkv"

vf() { m4 ../vf.m4 - <<<"$1"; }

$FFMPEG -y -ss 00:04:30 -t 40 -i "${VIDEO}" \
    -lavfi "[0]crop=w='ih/(16/9)':x='(in_w-out_w)/2 + ((sin((t*.19)+PI/2+1)+1)*75+150)'" \
    -c:a copy \
    out.mp4

$FFMPEG -y -i out.mp4 -loop 1 -i foo.png \
    -lavfi "$(vf "
       [1:v]
           format=rgba,
           scale=
               w='if(lt(t,26.5),
                     iw,
                     lerp(iw,iw*1.4,min(1,((t-26.5)/3))))':
               h='if(lt(t,26.5),
                     ih,
                     lerp(ih,ih*1.4,min(1,((t-26.5)/3))))':
               eval=1,
           fade=t=in:  st=13.5: d=3: alpha=1,
           fade=t=out: st=26.5: d=8: alpha=1
       [i];
       [0:v][i]
           overlay=
               x='if(lt(t,26.5),
                     50,
                     lerp(50,(W/2-w/2),min(1,((t-26.5)/3))))':
               y='if(lt(t,26.5),
                     50,
                     lerp(50,(H/2-h/2),min(1,((t-26.5)/3))))'")" \
    -shortest \
    card.mp4

mpv -loop 0 -volume 0 -ss 00:00:26 card.mp4
