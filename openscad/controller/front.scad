include <BOSL2/std.scad>

include <./parts/buttonh.scad>
include <./parts/buttond.scad>
include <./parts/pcbd.scad>
include <./parts/pcbo.scad>

body_rounding        = 20;
body                 = [100,50,3];
body_wedge_height    = 10 + 2.4;
body_wedge_thickness = 2;
xseparation          = 22;                                   // between pcb's
yseparation          = pcbd_l.y/2;                           // offset buttons from centre of x-axis in y
zseparation          = buttonh.z - body.z - buttonh_wedge.z; // body to adjust buttons
zpcbseparation       = pcbo.z + switch.z + buttonh.z + buttonh_switch.z + 0.1;

module 2buttons(pad_middle = 0.4, dt=0, zoff=0) {
  left(buttonh.x/2  + pad_middle) buttonh(dt);
  right(buttonh.x/2 + pad_middle) buttonh(dt);
}
module 2pcb() {
  back(6) left(3.2) up(zpcbseparation) xrot(180)
    pcbd();
}
module 1button(dt=0) {
  buttond(dt);
}
module 1pcb() {
  back(5) right(5.4) up(zpcbseparation) xrot(180)
    pcbo();
}

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
      // middle
      right(1) cuboid([19,body.y,body_wedge_height],anchor=BOTTOM);
    }
  }
  // cutout of misc parts
  fwd(yseparation) {
    right(xseparation) {
      1button(dt=0.3);
      1pcb();
    }
    left(xseparation) {
      2buttons(dt=0.3);
      2pcb();
    }
  }
}


// misc parts
fwd(yseparation) {
  right(xseparation) {
    1button();
    1pcb();
  }
  left(xseparation) {
    2buttons();
    2pcb();
  }
}
