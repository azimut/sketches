include <BOSL2/std.scad>

switch = [6.8,6.3,9];

module switch() {
  cuboid(switch, anchor=BOTTOM);
}
