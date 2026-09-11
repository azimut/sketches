#include "colors.inc"
#include "stones.inc"
#include "rad_def.inc"
#default {finish {ambient 0}}

global_settings {
  assumed_gamma 1.0
  radiosity{ Rad_Settings(7,on,off) }
}

light_source { <3,3,3> White fade_distance 15 fade_power 3 area_light x,y,5,5}
light_source { <-4,-2,0> White fade_distance 3 fade_power 3 area_light x,y,5,5}
camera { location <0,0,4> look_at <0,0.6,0> right x*image_width/image_height angle 65 }

superellipsoid {
  <0.3,0.3>
  translate y
  scale <2,0.5,1>
  texture {
    T_Grnt0
    normal {granite 1 scale .3}
  }
}
