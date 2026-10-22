# 4.7 - Most frequent brightness of the surrounding 36 values
magick LOGO: -gravity Center -crop 1:1+100+0  -fx "
    ret = 0.0;
    size = 10;
    for(idx=-size,idx<=size,
      for(jdx=-size,jdx<=size,
        ret += p[idx++,jdx++]));
    ret/(size*2)" show:
magick LOGO: -gravity Center -crop 1:1+100+0  -fx "
    ret = 0.0;
    size = 7;
    for(idx=-size,idx<=size,idx++;
      for(jdx=-size,jdx<=size,jdx++;
        ret += p[idx,jdx].lightness));
    ret/(size*size*2*2)" show:
