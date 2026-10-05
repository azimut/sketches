set -x
vf() { m4 ./vf.m4 - <<<"$1"; }
ffplay -autoexit -f lavfi \
       -i "$(vf "aevalsrc='pad(N(0),N(0)+2,mod(t,2))'")
                    :d=10
                    ,asplit=4[out1][a][b][c];
                [a]showfreqs='320x64':mode=dot:colors='green|red'[freq];
                [b]showspectrum='320x128'[spec];
                [c]showwaves=size='320x64':mode=point:colors='white|red':draw=full[wave];
                [wave][spec][freq]vstack=3:shortest=true"
