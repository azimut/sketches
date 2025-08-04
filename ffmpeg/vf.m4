define(`length',`hypot($1,$2)')dnl
define(`distance',`hypot(($1)-($3),($2)-($4))')dnl
define(`smoothstep',`(st(9,clip((($3)-($1))/(($2)-($1)),0,255));(ld(9)*ld(9)*(3-(2*ld(9)))))')dnl
