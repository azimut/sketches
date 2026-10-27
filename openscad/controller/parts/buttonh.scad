include <BOSL2/std.scad>
buttonh = [11.6,21.4,6.35];
buttonh_switch = [5,5,2];
buttonh_wedge = [5,1.5,1.4];
module buttonh(dt=0) {
  color("silver")
    cuboid(buttonh+[dt,dt,0],
           anchor=BOTTOM,
           rounding=0.8,
           edges="Z") {
    position(BACK +TOP) cube(buttonh_wedge, anchor=TOP+FRONT);
    position(FRONT+TOP) cube(buttonh_wedge, anchor=TOP+BACK);
    position(TOP) cube(buttonh_switch, anchor=BOTTOM);
  }
}
