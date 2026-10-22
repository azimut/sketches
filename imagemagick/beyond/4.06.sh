# 4.6 - TWIST - new [r , a] = ken[r , a + r /3]
magick LOGO: -fx "$(m4 fx.m4 - <<< "
  ii = i - w/2; jj = j - h/2;
  angle = PANGC + (PRADC/w)*3;
  p{cartx(PRADC,angle) + w/2,
    carty(PRADC,angle) + h/2}")" -rotate 90 out.png
