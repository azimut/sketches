# 4.19 - BACKGROUND - new[x,y] = (x/2)ˆ(y/2)
magick xc:black -geometry 300x -fx "aa=trunc(i/5); bb=trunc(j/5); min((aa&bb)|(aa&bb),1)" out.png
magick xc:black -geometry 256 -fx "aa=trunc(i/2); bb=trunc(j/2); ((aa|bb)&(~(aa&bb)))/w*2" out.png
