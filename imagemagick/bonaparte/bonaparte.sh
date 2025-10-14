#!/bin/sh
set -e
COVER=a1499432218_10.jpg
magick \
    "${COVER}" \
    -size '%[fx:w]x%[fx:w/(9/16)]' xc:'#'"$(convert "${COVER}" -format '%[hex:p{1,1}]' info:)" \
    +swap -gravity center -composite \
    bonaparte.jpg
sxiv bonaparte.jpg
