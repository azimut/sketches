# 4.20 - PIXELATION
# - new[x , y] = old[ (x/16)∗16 , (y/16)∗16 ]

magick LOGO: -fx "sz=14; p{ trunc(i/sz)*sz, trunc(j/sz)*sz  }" show:

# - new[r , a] = old[ (r/32)∗32 , (a/32)∗32 ]
# - szx number of rings  , -value +rings
# - szy width  of squares, +value -size

magick LOGO: -fx "
  szx=8; szy=16;
   ii = i - w/2 - w/3.5;
   jj = j - h/2 + h/9;
   rr = (hypot(ii,jj))      ;  aa = (atan2(jj,ii));
  rrr = (trunc(rr/szx)*szx) ; aaa = (trunc(aa*szy)/szy);
  p{ ((cos(aaa)*rrr)) + w/2 + w/3.5,
     ((sin(aaa)*rrr)) + h/2 - h/9 }" \
       show:
