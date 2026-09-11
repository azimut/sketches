// https://en.wikipedia.org/wiki/Simon_%28game%29
// $ povray Declare=BL=0 Declare=GL=0 Declare=RL=1 Declare=YL=0 +W1000 +H1000 +Q11 +A0.2 +UA +Ored.png board.pov
#include "colors.inc"
#include "finish.inc"

#declare r = 2;
#declare scaleby = 3;
#declare Mat_Body   = material {
  texture {
    pigment {White * 0.01}
    normal {granite 1 turbulence 1 scale .2}
    finish {diffuse .5 specular .01 roughness .001}
  }
}
#default {finish{ambient 0}}

light_source { <-50,100,-50>  White*.8 photons { refraction on reflection on } }
light_source { <10,5,5>  White*.4 photons { refraction on reflection on }}
light_source { 3*y White*.4 photons { refraction on reflection on } }
light_source { 3*z White*.4 photons { refraction on reflection on } }

camera {orthographic location <0,20,0> look_at 0 right x*image_width/image_height angle 35 }
//camera { ultra_wide_angle location <0,3,-4> look_at y right x*image_width/image_height angle 80 }

#macro cap(sphere_r,sphere_scale, mat)
  difference {
    sphere {0,sphere_r hollow material {mat} scale <sphere_scale,0.7,sphere_scale> }
    cylinder {<0,-10,0>,0,sphere_r*sphere_scale material {mat}}
  }
#end

#macro buttons(sphere_r,sphere_scale, mat)
  difference {
    intersection {
      object { cap(sphere_r, sphere_scale, mat) }
      cylinder {-10*y,10*y,r*sphere_scale-0.75 material {mat}}
    }
    cylinder {-10*y,10*y,2 material {mat}}
    box { 0,1 material {mat} translate <-0.5,-0.5,-0.5> scale <20,5,1> }
    box { 0,1 material {mat} translate <-0.5,-0.5,-0.5> scale <20,5,1>  rotate 90*y }
  }
#end

#macro body(sphere_r, sphere_scale, mat)
  difference {
    union {
      cap(sphere_r,sphere_scale, mat)
      cylinder {-1.5*y,0,sphere_r*sphere_scale material{mat}}
    }
    object { buttons(r,sphere_scale, mat) translate y*.1 }
    cylinder {-0.7*y,1*y,1.6 material{mat} translate 2*y}
  }
  disc {1.31*y,y,1.55 pigment {Gray05} finish {specular .01 roughness .1 reflection {.8} diffuse .2 irid {.4}}}
#end

#macro button(sphere_r, sphere_scale, mat, n)
  intersection {
    buttons(sphere_r,sphere_scale, mat)
    box {0,1 scale <10,1,10> rotate n*90*y material{mat}}
  }
#end

#macro makemat(mycolor, emmit)
  material {
    texture {
      pigment {mycolor}
      finish {
        diffuse 0.2
        specular 0.3
        roughness 0.01
        #if (emmit) emission 1 #end
        reflection { 0.3 1.0 fresnel on }
      }
    }
    interior { ior 1.5 }
  }
#end

#ifndef (GL) #declare GL=true; #end
#ifndef (RL) #declare RL=false; #end
#ifndef (YL) #declare YL=false; #end
#ifndef (BL) #declare BL=false; #end

body(r,scaleby,Mat_Body)
object {button(r,scaleby,makemat(Green ,  GL), 0)  #if (GL) translate 0 #else translate 0.25*y #end}
object {button(r,scaleby,makemat(Red   ,  RL), 1)  #if (RL) translate 0 #else translate 0.25*y #end}
object {button(r,scaleby,makemat(Yellow,  YL), 2)  #if (YL) translate 0 #else translate 0.25*y #end}
object {button(r,scaleby,makemat(Blue  ,  BL), 3)  #if (BL) translate 0 #else translate 0.25*y #end}

#if (GL) light_source { < 2.5,2, 2.5> 3*Green  } #end
#if (YL) light_source { <-2.5,2,-2.5> 3*Yellow } #end
#if (RL) light_source { < 2.5,2,-2.5> 3*Red    } #end
#if (BL) light_source { <-2.5,2, 2.5> 3*Blue   } #end

#include "rad_def.inc"
global_settings {radiosity{Rad_Settings(7,true,true)} photons { count 100000 }}
//global_settings {radiosity{Rad_Settings(2,false,false)}}