# 4.5 - "The picture was created by randomly selecting dots and sliding them down the page until a darker dot was met."

magick LOGO: -gravity Center -crop 1:1+100+0 -fx "
  current = p{i,j};
  above   = p{i,j}*0;
  offset  = j;
  while(offset >= 0  &&  offset < h   &&  above <= current,
    offset  = offset - 1;
    above   = p{i,offset};
    current = (above < current + 0.01) ? above : current);
  current" out.png
