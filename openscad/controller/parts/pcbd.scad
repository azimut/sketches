include <BOSL2/std.scad>
include <./switch.scad>

pcbd = [30,33,1.6];

module pcbd(dt=0) {
  pcbd_l = [9.3,9.9,pcbd.z];
  pcbd_real = pcbd + [dt,dt,0];
  color("green") {
    move([pcbd.x/2 + pcbd_l.x/2,
          pcbd_real.y/2 - pcbd_l.y/2 - 5.5,
          0])
      cuboid(pcbd_l,
             rounding=1,
             edges=[RIGHT+FRONT, RIGHT+BACK],
             anchor=BOTTOM) {
      // screws
      right(1.5) zcyl(r=1.5,h=10,anchor=BOTTOM);
      left(33-1.5) zcyl(r=1.5,h=10,anchor=BOTTOM);
    }
    // main
    cuboid(pcbd_real,
           anchor=BOTTOM,
           rounding=1,
           edges="Z") {
      // buttons
      position(TOP) back((pcbd.y/2)-(switch.y/2) - 7.4) {
        right((pcbd.x/2) - (switch.x/2) - 2)
          switch();
        right((pcbd.x/2) - (switch.x/2) - 2 - switch.x - 6.3)
          switch();
      }
    }
  }
}
