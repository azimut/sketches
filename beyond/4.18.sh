# 4.18 - new [r , a] = karen[r , a + karen[r , a]/8]
magick LOGO: -fx "$(m4 fx.m4 - <<< \
  "fang = PANG * p{ cartx(PRAD,PANG),
                    carty(PRAD,PANG) }*6;
   p{ cartx(PRAD,fang) , carty(PRAD,fang) }" )" \
       show:
magick LOGO: -gravity Center -crop 1:1 -resize 1024x -fx "$(m4 fx.m4 - <<< \
  "ii = i - w/2; jj = j - h/2;
   fang = PANGC + p{ cartx(PRADC,PANGC) + w/2,
                     carty(PRADC,PANGC) + h/2} * 25.5;
   p{ cartx(PRADC,fang) + w/2 - w/4,
      carty(PRADC,fang) + h/2  }" )" \
       show:
