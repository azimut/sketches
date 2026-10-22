# 4.4 - new[ x , y − jlb[x,y]/4 ] = jlb[x , y]

magick LOGO: -fx "p{ i , j-(intensity/4*w) }.intensity" out.png
magick LOGO: -gravity Center -crop 1:1+100+0 -resize 50% -fx '
  foundY = -1;
  dtY = 50;
  for(srcY=(j-dtY), srcY<(j+dtY),
    srcY++;
    if (srcY + int(p{i,srcY}.lightness*dtY) == j,
        foundY = srcY,
        0));
  foundY < 0 ? 0 : p{i,foundY}' out.png
