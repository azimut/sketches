include <BOSL2/std.scad>
include <./switch.scad>

pcbo = [27.3,31.8 ,1.6];
pcbo_l = [12.1,10.2,pcbo.z];

module pcbo(dt=0, screwside=false) {
  pcbo_real = pcbo + [dt,dt,0];
  color("green") {
    move([-pcbo_real.x/2 - pcbo_l.x/2,
          pcbo_real.y/2 - pcbo_l.y/2 - 5.5,
          0])
      // ear
      cuboid(pcbo_l + [0.01,0,0],
             rounding=1,
             edges=[LEFT+FRONT, LEFT+BACK],
             anchor=BOTTOM) {
      // screws
      position(screwside ? TOP : BOTTOM) {
        left(pcbo_l.x/4) zcyl(r=1.5,h=10,anchor=screwside ? BOTTOM : TOP);
        right(32-pcbo_l.x/4) zcyl(r=1.5,h=10,anchor=screwside ? BOTTOM : TOP);
      }
    }
    // mainpcb
    cuboid(pcbo_real,
           anchor=BOTTOM,
           rounding=1,
           edges="Z") {
      // button
      back((pcbo_real.y/2)-(switch.y/2) - 7.4) {
        left((pcbo_real.x/2) - (switch.x/2) - 5)
          position(TOP) switch();
      }
    }
  }
}
