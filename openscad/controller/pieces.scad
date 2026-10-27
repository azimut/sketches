include <BOSL2/std.scad>

include <./parts/buttonh.scad>
include <./parts/buttond.scad>
include <./parts/pcbd.scad>
include <./parts/pcbo.scad>

zpcbseparation = pcbo.z + switch.z + buttonh.z + buttonh_switch.z + 0.1;

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

module pieces(dt=0,xsep=22,ysep=pcbd_l.y/2) {
  fwd(ysep) {
    right(xsep) {
      1button(dt=dt);
      1pcb();
    }
    left(xsep) {
      2buttons(dt=dt);
      2pcb();
    }
  }
}
