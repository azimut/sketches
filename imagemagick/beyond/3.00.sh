#!/bin/bash

# 3 The Digital Darkroom
# ======================
# 3.1 - new [x , y] = x + y
magick xc:black -geometry 200x200 -fx "((i+j)%(w/10))/(w/10)" out.png
# 3.2 - new [x , y] = (x ∗y )%(Z + 1)
magick xc:black -geometry 300x300 -fx "((i*j)%(w*10))/(w*10)" out.png
# 3.3 - new [x , y] = (Z ∗x ∗y )/((X − 1)∗(Y − 1))
magick xc:black -geometry 200x200 -fx "(i*j)/(w*h)" out.png
# 3.4 - new[x , y] = x % y
# 3.5 - new[x , y] = y + (sin(x)∗Z )/2
# 3.6 - new[x , y] = (atan(y − Y /2, x − X /2) ∗Z ) / 360
magick xc:black -geometry 200x200 -fx "$(m4 fx.m4 - <<< "map(atan2(j-(h/2),i-(w/2)),-2.5,2.5,0,1)")" out.png
# 3.9 - new [x , y] = ((x %(5 + y /25)) > 5)?0: Z
magick xc:black -geometry 512x -fx "!((i % (5 + j/25)) > 5)" out.png
# 3.10 - new[x , y] = (Z∗abs( x%sin(y) ) > 10) ? 0 : Z
magick xc:black -geometry 512x512 -fx "!((abs( i % (sin(j)*512) ))/512 > 0.06)" out.png
# 3.11 - new[r , a] = (Z ∗r)/R
magick xc:black -geometry 200x200 -fx "(hypot(i-w/2,j-h/2))/180" out.png
# 3.12 - new[r , a] = (((a + r)%16) − 8)∗Z/16 + Z/2
magick xc:black -geometry 500x500 \
       -fx "ii=i-w/2;jj=j-h/2;
            aa=atan2(jj,ii);rr=hypot(ii,jj);
            (((aa+rr)%16)-8)* 1/16 + 1/2" out.png
# 3.13 - new[x , y] = Z − old [x , y]
magick LOGO: -fx "1-luma" out.png
# 3.14 - new[x , y] = Z ∗ log(old [x , y])/log (Z)
magick LOGO: -fx "abs(log(luma))" out.png
