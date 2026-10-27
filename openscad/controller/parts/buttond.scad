include <BOSL2/std.scad>
buttond = [17.5,23.3,6.3];
buttond_switch = [5,12.1,2];
buttond_wedge = [1.4,9.4,1.75];
module buttond(dt=0) {
  color("silver")
    cuboid(buttond+[dt,dt,0],
           anchor=BOTTOM,
           rounding=0.8,
           edges="Z") {
    position(LEFT +TOP) cube(buttond_wedge, anchor=TOP+RIGHT);
    position(RIGHT+TOP) cube(buttond_wedge, anchor=TOP+LEFT);
    position(TOP) cube(buttond_switch, anchor=BOTTOM);
  }
}
