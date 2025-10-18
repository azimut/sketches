#!/bin/bash
set -e

FONT=/usr/share/fonts/truetype/dejavu/DejaVuSansMono.ttf
FFMPEG=/usr/bin/ffmpeg

$FFMPEG -y -t 10 -f lavfi -i color=black:720x1280 \
    -lavfi "[0]
            drawtext=fontcolor=white:fontfile=${FONT}:fontsize=30:text='$(python3 -c "print(('Hello World! '*3 + '\n')*120)")':y='mod(t*225,h) - h':enable='lt(t,5)':x=20,
            drawtext=fontcolor=white:fontfile=${FONT}:fontsize=50:text='$(python3 -c "print(('Hell World! '*4 + '\n')*80)")':y='mod(t*150,h) - h':enable='between(t,5,6)':x='-135',
            drawtext=fontcolor=white:fontfile=${FONT}:fontsize=30:text='$(python3 -c "print(('Hello World! '*3 + '\n')*120)")':y='mod(t*150,h) - h':enable='gt(t,6)':x=20,
            split[text][text2];
            [text]
                boxblur=3:2:10:30
            [blured];
            [text2]
                drawtext=fontcolor=white:fontfile=${FONT}:fontsize=15:text='avoid':x='(w/2)-30+sin(t*50)*2':y='(h/2)-5-sin(t*2)':enable='lt(t,5) + gt(t,6)',
                drawtext=fontcolor=white:fontfile=${FONT}:fontsize=35:text='people':x='(w/2)-60+sin(t*50)*2':y='(h/2)-5-sin(t*2)':enable='between(t,5,6)'
            [text3];
            [blured][text3]
                blend=addition,
                reverse
                " \
    foo.mp4

mpv -loop foo.mp4
