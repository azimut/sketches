include <BOSL2/std.scad>
pcbd = [30,33,1.6];
pcbd_button = [6.3,6.3,9];
// top distance5.5 w39   height9.7   centerdist30
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
      zcyl(r=1.5,h=10,anchor=BOTTOM);
      left(33) zcyl(r=1.5,h=10,anchor=BOTTOM);
    }
    cuboid(pcbd_real,
           anchor=BOTTOM,
           rounding=1,
           edges="Z") {
      back((pcbd.y/2)-(pcbd_button.y/2) - 7.4) {
        right((pcbd.x/2) - (pcbd_button.x/2) - 2)
          cuboid(pcbd_button, anchor=BOTTOM);
        right((pcbd.x/2) - (pcbd_button.x/2) - 2 - pcbd_button.x - 6.4)
          cuboid(pcbd_button, anchor=BOTTOM);
      }
    }
  }
}
