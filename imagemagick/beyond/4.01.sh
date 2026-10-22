# 4.1 - EINSTEIN - Cartesian -> Polar -> Cartesian
# new [x , y] = margaret [cartx(sqrt(r ∗ 400), a), carty(sqrt(r ∗ 400), a)]
magick LOGO: -fx "
    ii = i - w/2;
    jj = j - h/2;
    rr = hypot(ii,jj);
    aa = atan2(jj,ii);
    p{ cos(aa)*sqrt(rr*400)+w/2,
       sin(aa)*sqrt(rr*300)+h/2 }" \
       out.png
