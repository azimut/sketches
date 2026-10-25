include <BOSL2/std.scad>
buttond();
module buttond(dt=0) {
  cuboid([17.5,23.3,6.3]+[dt,dt,0],
         anchor=BOTTOM,
         rounding=0.8,
         edges="Z") {
    position(LEFT +BOTTOM) cube([1.4,9.4,1.75], anchor=BOTTOM);
    position(RIGHT+BOTTOM) cube([1.4,9.4,1.75], anchor=BOTTOM);
    position(BOTTOM) cube([5,12.1,2], anchor=TOP);
  }
}
