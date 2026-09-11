#version 3.7;
#include "colors.inc"
#include "rad_def.inc"
#include "shapes.inc"
#include "shapesq.inc"
#default {finish {ambient 0}}

global_settings {
  assumed_gamma 1.0
  //radiosity{ Rad_Settings(7,on,off) }
}

light_source {<-3,4,-5> White fade_distance 10 fade_power 3 area_light x,z,5,5 jitter }
light_source {<10,4,10> White fade_distance 10 fade_power 3 }
//plane {y,-1 pigment {Gray20} }
camera { location <0,2,-4> look_at 0.5*y right x*image_width/image_height}
//background {White *.5}

object{
  Sinsurf scale <-1,1,1> translate <-10,-0.5,-20> rotate 90*y
  pigment { color rgb <0.2, 0.6, 0.9> }
  finish {
    ambient 0.1
    diffuse 0.6
    specular 0.4
    roughness 0.05
  }
}

// #declare F_1 = function(x, y, z) { y };
// #declare F_2 = function(x, y, z) { z+2 };
// #declare TT=0.5;
// isosurface {
//   function {
//     //F_2(x,y,z)
//     // min(F_1(x,y,z), F_2(x,y,z))
//     (1+TT) -pow(TT,F_1(x,y,z)) -pow(TT,F_2(x,y,z))
//   }
//   contained_by { box { <-4, -4, -4>*3, <4, 4, 4>*3 } }
//   open
//   accuracy 0.001
//   max_gradient 4
//   pigment { color rgb <0.2, 0.6, 0.9> }
//   finish {
//     ambient 0.1
//     diffuse 0.6
//     specular 0.4
//     roughness 0.05
//   }
// }
sphere {
  0, 1
  translate 0.5*y
  material {
    texture {
      pigment {Green}
    }
  }
}