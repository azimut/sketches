include <BOSL2/std.scad>

include <./parts/buttonh.scad>
include <./parts/buttond.scad>
include <./parts/pcbd.scad>
include <./parts/pcbo.scad>

body_rounding = 15;
body = [100,50,3];
xseparation = 22;
yseparation = pcbd_l.y/2;

module 2buttons(pad_middle = 0.1, dt=0, zoff=0) {
  left(buttonh.x/2  + pad_middle) buttonh(dt);
  right(buttonh.x/2 + pad_middle) buttonh(dt);
}
module 2pcb() {
  back(6) left(3.2) up(1.6 + switch.z + buttond.z + 2.2) xrot(180)
    pcbd();
}
module 1button(dt=0) {
  buttond(dt);
}
module 1pcb() {
  back(5) right(5.4) up(1.6 + switch.z + buttond.z + 2.2) xrot(180)
    pcbo();
}

difference() {
  up(buttonh.z - body.z - buttonh_wedge.z) up(0.01)
    cuboid(body, rounding=body_rounding, edges="Z", anchor=BOTTOM);
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
