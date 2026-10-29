include <BOSL2/std.scad>
include <./switch.scad>

pcbd = [30,33,1.6];
pcbd_l = [9.3,9.9,pcbd.z];

module pcbd(dt=0, screwside=false, switches=true) {
  pcbd_real = pcbd + [dt,dt,0];
  color("green") {
    move([pcbd_real.x/2 + pcbd_l.x/2,
          pcbd_real.y/2 - pcbd_l.y/2 - 5.5,
          0])
      cuboid(pcbd_l + [dt,dt,0],
             rounding=1,
             edges=[RIGHT+FRONT, RIGHT+BACK],
             anchor=BOTTOM) {
      // screws
      position(screwside ? TOP : BOTTOM) {
        right(1.5) zcyl(r=1.5,h=10,anchor=screwside ? BOTTOM : TOP);
        left(33-1.5) zcyl(r=1.5,h=10,anchor=screwside ? BOTTOM : TOP);
      }
    }
    // main
    cuboid(pcbd_real,
           anchor=BOTTOM,
           rounding=1,
           edges="Z") {
      // buttons
      if(switches)
        position(TOP) back((pcbd_real.y/2)-(switch.y/2) - 7.4) {
        right((pcbd_real.x/2) - (switch.x/2) - 2)
          switch();
        right((pcbd_real.x/2) - (switch.x/2) - 2 - switch.x - 6.3)
          switch();
      }
    }
  }
}
