define(`step', `(($2) < ($1)) ? 0 : 1')dnl
define(`fract', `($1) - int($1)')dnl
define(`mix',`(($1)*(1-($3))) + (($2)*($3))')dnl
define(`smoothstep',`(tt=clamp((($3)-($1))/(($2)-($1)));tt*tt*(3-(2*tt)))')dnl
define(`length',`hypot($1,$2)')dnl
define(`distance',`hypot(($1)-($3),($2)-($4))')dnl
define(`dot',`(($1)*($3) + ($2)*($4))')dnl
define(`init',`ii=((i*2)-w)/h; jj=((j*2)-h)/h')dnl
define(`clamp',
       `ifelse(`$#',`1',``clamp($1)'',
               `$#',`3',`min(max($1,$2),$3)')')dnl
