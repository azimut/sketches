divert(-1)
define(`length',`hypot($1,$2)')
define(`distance',`hypot(($1)-($3),($2)-($4))')
define(`smoothstep',`(pow(clip((($3)-($1))/(($2)-($1)),0,1),2)
                      *(3-(2*clip((($3)-($1))/(($2)-($1)),0,1))))')
define(`sign',`if(gt($1,0), 1, -1)')
define(`TWOPI',`(2*PI)')
define(`pluck',       `sin(TWOPI*($1)*($2))  * exp(-3*($2)) * 0.1')
define(`square', `sign(sin(TWOPI*($1)*($2))) * exp(-3*($2)) * 0.1')
define(`saw',    `(mod(($1)*($2),1) * 2 - 1) * exp(-3*($2)) * 0.1')
define(`fmpluck',`fm($1,$2,1,1)              * exp(-3*($2)) * 0.1')
define(`fract', `(($1) - floor($1))')
define(`fm',     `sin(TWOPI*fract(($1)*($2)) + (($3) * sin(TWOPI*fract(($4)*($2)))))')
define(`interval',`pow(2,($1)/12)')
define(`pad',
        `(  fm(($1)  ,($2),1,($1)-1.00) * 0.09
          + fm(($1)+2,($2),1,($1)+1.00) * 0.04) * smoothstep(0,0.3,($2))')
define(`at', `pushdef(`it', `$1') $2 popdef(`it')')
divert`'
