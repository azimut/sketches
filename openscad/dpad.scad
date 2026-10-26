include <BOSL2/std.scad>

height         = 12;
radius_spacing = 2;
diameter_max   = 31.5;
radius_max     = diameter_max / 2;
radius         = radius_max - radius_spacing;

module dpad(ch=15,cr1=2,cr2=7) {
  difference() {
    zcyl(r1=radius, r2=radius, h=height, anchor=BOTTOM, rounding2=2);
    up(ch) cylinder(r1=cr1,r2=cr2,h=radius,orient=LEFT+FRONT);
    up(ch) cylinder(r1=cr1,r2=cr2,h=radius,orient=LEFT+BACK);
    up(ch) cylinder(r1=cr1,r2=cr2,h=radius,orient=RIGHT+BACK);
    up(ch) cylinder(r1=cr1,r2=cr2,h=radius,orient=RIGHT+FRONT);
    up(radius*3+10) sphere(r=radius*3);
    zcyl(r=1.5,h=10,anchor=BOTTOM);
  }
}

$fn=100;
dpad();
