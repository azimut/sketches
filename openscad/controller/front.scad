include <BOSL2/std.scad>

include <./pieces.scad>

body_rounding        = 20;
body                 = [100,50,3];
body_wedge_height    = 10 + 2.4;
body_wedge_thickness = 2;
zseparation          = buttonh.z - body.z - buttonh_wedge.z; // body to adjust buttons

module front() {
  difference() {
    // body
    up(zseparation) up(0.01) {
      // base
      cuboid(body, rounding=body_rounding, edges="Z", anchor=BOTTOM);
      // wedge
      up(body.z) {
        difference() {
          cuboid([body.x,body.y,body_wedge_height], rounding=body_rounding, edges="Z", anchor=BOTTOM);
          cuboid([body.x-body_wedge_thickness*2,body.y-body_wedge_thickness*2,body_wedge_height*3], rounding=body_rounding, edges="Z");
        }
      }
    }
    pieces(dt=0.3);
  }
}

// front();
pieces();
