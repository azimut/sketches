divert(-1)
define(`length',`hypot($1,$2)')
define(`distance',`hypot(($1)-($3),($2)-($4))')
define(`lerp',`(($1)+(($3)*(($2)-($1))))')
define(`smoothstep',`(pow(clip((($3)-($1))/(($2)-($1)),0,1),2)
                   *(3-(2*clip((($3)-($1))/(($2)-($1)),0,1))))')
define(`sign',`if(gt($1,0), 1, -1)')
define(`fract', `(($1) - floor($1))')
define(`exp2', `(pow(2,($1)))')
define(`TWOPI',`(2*PI)')

define(`interval',`pow(2,($1)/12)')
define(`at', `pushdef(`it', `$1') $2 popdef(`it')')
# N(s) - where "s" is a semitone number relative to middle C, aka C4
define(`N', `(440 * exp2((($1)-9)/12))')
# fade(n,t)
define(`fade', `exp(-($1)*($2))')

# f = frequency  e = release
# pluck(f,e,t)
define(`pluck',       `sin(TWOPI*($1)*($3))  * exp(-($2)*($3)) * 0.1')
# square(f,e,t)
define(`square', `sign(sin(TWOPI*($1)*($3))) * exp(-($2)*($3)) * 0.1')
# saw(f,e,t)
define(`saw', `(mod(($1)*($3),1) * 2 - 1) * exp(-($2)*($3)) * 0.1')
# fm(fc,fm,iom,t) - NOTE: fract() helps to not break after a few seconds (floats?)
define(`fm', `sin(TWOPI*fract(($1)*($4)) + (($3) * sin(TWOPI*fract(($2)*($4)))))')
# fmpluck(fc,fm,iom,e,t)
define(`fmpluck',`fm($1,$2,$3,$5) * exp(-($4)*($5)) * 0.1')
# pad(fc,fm,t)
define(`pad',
        `(  fm(($1)  ,($2)-1,1,($3)) * 0.09
          + fm(($1)+2,($2)+1,1,($3)) * 0.04)
         * smoothstep(0,.3,($3))')
divert`'
