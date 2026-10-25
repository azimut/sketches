include <BOSL2/std.scad>
include <./buttonh.scad>

// buttonh();

body = [20,20,2];

difference() {
  hull() {
    cuboid(body, rounding=1, anchor=BOTTOM, edges="Z");
    difference() {
      up(body.z) spheroid(r=body.x/2);
      cuboid(body*10,anchor=TOP);
    }
  }
}
