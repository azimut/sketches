v#!/bin/bash
set -xe
FFMPEG='/home/sendai/Downloads/ffmpeg-master-latest-linux64-gpl/bin/ffmpeg'
INPUT='/home/sendai/Capri - Pantera [j4jqw1cS4mk].mp4' # 160x128
# ffmpeg -hide_banner -y \
#     -f lavfi -i "color=black:160x256" \
#     -ss 00:00:27 -t 14 -i "${INPUT}" \
#     -lavfi "[0][1]overlay=x=(W/2)-(w/2):y=(H/2)-(h/2):shortest=true" \
#     pantera.mp4
# mpv -loop pantera.mp4

# -f lavfi -i "color=black:160x256" \
# -ss 00:00:41.4 -t 5.2 -i "${INPUT}" \
# ------------------------------------
# [1:v]split[half1][half2];
# [half1]hflip[vhalf1];
# [vhalf1][half2]vstack[stacked];
# [0:v][stacked]overlay=x=(W/2)-(w/2):y=(H/2)-(h/2):shortest=true
# --------------------------
# [0]split=4[side1][side2][side3][side4];
# [side2]hflip,select='eq(n,0)'[side2];
# [side1][side2]vstack[stack1];
# [side3]select='eq(n,0)'[side3];
# [side4]hflip[side4];
# [side3][side4]vstack[stack2];
# [stack1][stack2]concat[scene1];
# ----------------------------------
# -ss 00:00:35.5 -t 5 -i "${INPUT}" \
$FFMPEG -nostdin -hide_banner -y \
    -ss 00:00:41.4 -t 2.8 -i "${INPUT}" \
    -ss 00:00:44.3 -t 2.3 -i "${INPUT}" \
    -ss 00:01:04.8 -t 1.2 -i "${INPUT}" \
    -ss 00:01:08.3 -t 1.2 -i "${INPUT}" \
    -ss 00:01:01.2 -t 3.5 -i "${INPUT}" \
    -ss 00:01:07 -t 1.3 -i "${INPUT}" \
    -ss 00:01:09.6 -t 4.5 -i "${INPUT}" \
    -ss 00:01:14.2 -t 1 -i "${INPUT}" \
    -f lavfi -i "color=black:180x320" \
    -an \
    -lavfi "[4][5][6]concat=3[frag1];
            [1]hflip[1flip];
            [1flip][2][3][7]concat=4,setpts=1.3*PTS[frag2];
            [frag1][frag2]vstack[scene];

            [8][scene]overlay=x=(W/2)-(w/2):y=(H/2)-(h/2):shortest=true" \
    pantera.mp4
mpv -loop pantera.mp4
