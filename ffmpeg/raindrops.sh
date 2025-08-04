ffmpeg -y -t 6 -f lavfi -i "nullsrc=720x900" \
    -lavfi "[0:v] geq='tan(hypot(X*0.15*W, Y*.2))
                       * exp(T-E)
                       * 2':128:128,
                  split             [bar][baz];
            [bar] reverse,fifo      [r];
            [baz][r] concat=n=2:v=1 [v]" \
    -map '[v]' "${0##*/}.mp4"
