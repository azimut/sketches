#!/bin/bash
# https://www.shadertoy.com/view/tdsXRr
fx() { m4 fx.m4 - <<<"$1"; }
convert -size 1080x1350 -monitor \
    xc:'device-rgb(0.4,0.6,0.7)' \
    xc:'device-rgb(0.9,0.7,0.6)' \
    -fx "$(fx 'init(); ii*=0.9; jj*=0.9;
               aa=(u * (0.8 - distance(ii,jj,-0.1,-0.1)));
               bb=(v * (0.6 - distance(ii,jj,0.25,0.3)));
               dd=distance(ii,jj,0,0);
               ff=(1 - smoothstep(0.6,0.61,dd));
               ((aa+bb)*(ff+sin(1)*jj*.2)) ')" \
    -flip "${0##*/}.png"
