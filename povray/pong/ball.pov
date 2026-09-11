#version 3.7;
#include "colors.inc"
#include "stones.inc"
#include "finish.inc"
#include "rad_def.inc"
#include "skies.inc"
#include "glass.inc"
#default {texture {finish {ambient 0}}}
global_settings {
  assumed_gamma 1.0
  radiosity{ Rad_Settings(3,on,on) }
  photons { count 20000 }
}

light_source {<-3,4,-5> White fade_distance 10 fade_power 3 area_light x,z,5,5 jitter photons {reflection on refraction on }}
// light_source {<10,-4,-10> White fade_distance 10 fade_power 3 photons {reflection on refraction on } }
//plane {y,-1 pigment {Black} }
camera { location <0,0,-4> look_at 0 right x*image_width/image_height}
background {White *.5}
sphere {
  0, 1
  translate .1*y
  hollow on
  material {
    texture {
      pigment {Green filter 1}
      finish {
        specular .6
        roughness .002
        ambient 0
        diffuse .1
        brilliance 5
        reflection { .1, 1.0 fresnel on }
        conserve_energy
      }
    }
    interior {
      I_Glass_Exp(2)
    }
  }
  photons {
    target
    reflection on
    refraction on
    collect off
  }
}
