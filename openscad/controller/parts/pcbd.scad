include <BOSL2/std.scad>
pcbd = [30,33,1.6];
pcbd_button = [6.3,6.3,9];
// top distance5.5 w39   height9.7   centerdist30
module pcbd(dt=0) {
  cuboid(pcbd + [dt,dt,0],
         anchor=BOTTOM,
         rounding=0.5,
         edges="Z") {
    back((pcbd.y/2)-(pcbd_button.y/2) - 7.4) {
      right((pcbd.x/2) - (pcbd_button.x/2) - 2)
        cuboid(pcbd_button, anchor=BOTTOM);
      right((pcbd.x/2) - (pcbd_button.x/2) - 2 - pcbd_button.x - 6.4)
        cuboid(pcbd_button, anchor=BOTTOM);
    }
  }
}
pcbd();
