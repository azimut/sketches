# 4 Altered Images
# ================

# NOTE: Try -negate .lightness .intensity .saturation .hue, different thresholds, different directions

# 4.8 - new [x , y] = luca[ x(a)∗X/A , y(r)∗Y/R ]
# 4.9
# "In this case a number of rows and columns are shifted at a time...
#  shift = random(0,32) <^v>
#  width = random(8,40)

# 4.11 - BROKEN
# new[x,y] = greg[x,y]ˆ(greg[x,y]∗factor)>>17
# factor = (128-(x-128)∗(x-128) - (y-128)∗(y-128))
# magick LOGO: -fx "
#   dt = 128;
#   factor = (dt-(i-dt)*(i-dt) - (j-dt)*(j-dt));
#   aa = int(p{i,j}.lightness*w);
#   bb = int(p{i,j}.lightness*factor*h);
#   (((aa|bb)&(~(aa&bb))))/w" show:

# 4.12 - new [x , y] = ava[ x + sin(C1∗x )∗C2 , y + sin(y)∗C3 ]
# 4.14 - new [r , a] = psl[(r ∗r )/R , a]
