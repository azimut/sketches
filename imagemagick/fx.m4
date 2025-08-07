divert(-1)
define(`init',`ii=((i*2)-w)/h; jj=((j*2)-h)/h')
define(`radians',`($1 * (pi / 180))')
define(`rotate', `ii=ii*cos($1) - jj*sin($1);
                  jj=ii*sin($1) + jj*cos($1)')
define(`step', `(($2) < ($1)) ? 0 : 1')
define(`fract', `(($1) - int($1))')
define(`mix',`((($1)*(1-($3))) + (($2)*($3)))')
define(`smoothstep',`(tt=clamp((($3)-($1))/(($2)-($1)));tt*tt*(3-(2*tt)))')
define(`length',`hypot($1,$2)')
define(`distance',`hypot(($1)-($3),($2)-($4))')
define(`dot',`(($1)*($3) + ($2)*($4))')
define(`clamp',
       `ifelse(`$#',`1',``clamp($1)'',
               `$#',`3',`min(max($1,$2),$3)')')
define(`hash',`fract(sin($1)*43758.5453)')
define(`N21',`fract(sin(($1)*100+($2)*6574)*5647)')
define(`noise',
       `noisefx=fract($1); noisefx=noisefx*noisefx*(3.0-(2.0*noisefx));
        noisefy=fract($2); noisefy=noisefy*noisefy*(3.0-(2.0*noisefy));
        noisen=floor($1)+(floor($2)*57.0);
        mix(mix(hash(noisen)     , hash(n +  1.0), noisefx),
            mix(hash(noisen+57.0), hash(n + 58.0), noisefx),
            noisefy)')
divert`'dnl
