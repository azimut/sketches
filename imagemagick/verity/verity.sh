#!/bin/sh
# Description: just some background for an ig story
# resize + add negative space + color aberration
set -e
COVER='a3429147195_10.jpg'
convert "${COVER}" -resize 1000x \
    -size 1080x1920 xc:black \
    +swap -gravity South -composite \
    -channel R -fx 'u.p{i-5,j}.r' \
    -channel G -fx 'u.p{i+5,j}.g' \
    -channel B -fx 'u.p{i,j}.b' \
    +channel \
    verity.jpg
sxiv verity.jpg $COVER
