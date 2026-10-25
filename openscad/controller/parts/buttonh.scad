include <BOSL2/std.scad>

module buttonh(dt=0) {
  cuboid([11.6,21.4,6.35]+[dt,dt,0],
         anchor=BOTTOM,
         rounding=0.8,
         edges="Z") {
    position(BACK +BOTTOM) cube([5,1.5,1.4], anchor=BOTTOM);
    position(FRONT+BOTTOM) cube([5,1.5,1.4], anchor=BOTTOM);
    position(BOTTOM) cube([5,5,2], anchor=TOP);
  }
}
