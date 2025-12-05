#!/bin/bash
set -ex
images=(
    1zetsu.square.jpg
    2suckitup.jpeg
    3poly.square.jpg
    4saveyoursoul.jpeg
    5rope.jpeg
)
convert 1zetsu.jpg -gravity Center -extent 720x -resize 640x 1zetsu.square.jpg
convert 3poly.jpg -gravity Center -extent 720x -resize 640x 3poly.square.jpg
montage "${images[@]}" -background transparent -geometry 150x -border 10 -tile 1x5 montage.png
FONT="${HOME}/Downloads/spotifyfont/SpotifyMix-Regular.ttf"
label() {
    cat <<EOF
    font '${FONT/Regular/Bold}'
    fill white font-size 45 text -325,$((${3} + 10)) '${4}'
    font '${FONT}'
    fill white font-size 28 text 100,${3} '${1}'
    fill gray  font-size 23 text 100,$((${3} + 30)) '${2}'
EOF
}
rectangles() {
    local result=""
    local angle=0
    for ((i = 0; i < 30; i++)); do
        result+="rotate ${angle} stroke white rectangle 400,1120 700,1180"
        result+=$'\n'
        angle=$(dc -e '? 0.05 + p' <<<${angle})
    done
    echo "${result}"
}
# convert \
#     -size 720x1280 xc:black \
#     -draw "$(rectangles)" \
#     -gravity north -size 270x70 xc:white -geometry +0+50 \
#     -font "${FONT/Regular/Bold}" \
#     -draw "fill black font-size 35 text 0,10 'My Top Songs'" \
#     +composite \
#     -gravity center montage.png -geometry -200+0 \
#     +composite \
#     -draw "$(label 'Zetsubo' 'Prismbeings' '-390' '1')" \
#     -draw "$(label 'Suck It up' 'She Wants Revenge' '-200' '2')" \
#     -draw "$(label 'polyrhythmic music for microtonal angels' 'Zheanna Erose' '-10' '3')" \
#     -draw "$(label 'Save Your Soul' 'She Wants Revenge' '180' '4')" \
#     -draw "$(label 'Rope + Ring' 'Nymb' '370' '5')" \
#     final.png

montage "${images[@]}" -background transparent -geometry 150x -border 10 -tile 1x5 montage.png

rectangles() {
    local result=""
    local angle=0
    for ((i = 0; i < 30; i++)); do
        result+="rotate ${angle} stroke white rectangle 400,1150 1100,1180"
        result+=$'\n'
        angle=$(dc -e '? 0.05 + p' <<<${angle})
    done
    echo "${result}"
}

label() {
    cat <<EOF
    font '${FONT/Regular/Bold}'
    fill white font-size 45 text -480,$((${3} + 10)) '${4}'
    font '${FONT}'
    fill white font-size 28 text 180,${3} '${1}'
    fill gray  font-size 23 text 180,$((${3} + 30)) '${2}'
EOF
}

convert \
    -size 1080x1350 xc:black \
    -draw "$(rectangles)" \
    -gravity north -size 270x70 xc:white -geometry +0+50 \
    -font "${FONT/Regular/Bold}" \
    -draw "fill black font-size 35 text 0,10 'My Top Songs'" \
    +composite \
    -gravity center montage.png -geometry -300+0 \
    +composite \
    -draw "$(label 'Zetsubo' 'Prismbeings' '-390' '1')" \
    -draw "$(label 'Suck It up' 'She Wants Revenge' '-200' '2')" \
    -draw "$(label 'polyrhythmic music for microtonal angels' 'Zheanna Erose' '-10' '3')" \
    -draw "$(label 'Save Your Soul' 'She Wants Revenge' '180' '4')" \
    -draw "$(label 'Rope + Ring' 'Nymb' '370' '5')" \
    final.png

sxiv final.png
