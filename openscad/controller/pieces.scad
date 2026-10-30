include <BOSL2/std.scad>

include <./parts/buttonh.scad>
include <./parts/buttond.scad>
include <./parts/pcbd.scad>
include <./parts/pcbo.scad>

zpcbseparation = pcbo.z + switch.z + buttonh.z + buttonh_switch.z + 1;

module 2buttons(pad_middle = 0.4, dt=0, zoff=0) {
  left(buttonh.x/2  + pad_middle) buttonh(dt);
  right(buttonh.x/2 + pad_middle) buttonh(dt);
}
module 2pcb(dt=0,switches=true) {
  back(6) left(3.2) up(zpcbseparation) xrot(180)
    pcbd(dt=dt,switches=switches);
}
module 1button(dt=0) {
  buttond(dt);
}
module 1pcb(dt=dt,switches=true) {
  back(5) right(5.4) up(zpcbseparation) xrot(180)
    pcbo(dt=dt,switches=switches);
}

module pieces(dt=0,xsep=21,ysep=pcbd_l.y/1.8,pad_middle=0.4,switches=true) {
  fwd(ysep) {
    right(xsep) {
      1button(dt=dt);
      1pcb(dt=dt,switches=switches);
    }
    left(xsep) {
      2buttons(dt=dt,pad_middle=pad_middle);
      2pcb(dt=dt,switches=switches);
    }
  }
}
