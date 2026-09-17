include <./bearing.scad>
include <BOSL2/std.scad>

body = [25,30,30];
epsilon = 0.001;
delta = 0.2;
holdrod_radius = 4;
holdrod_wall = 3;
spinrod_radius = bearing_idiameter/2 + epsilon;
angle = 45;

difference() {
  hull() {
    zmove(-15) xrot(angle) cyl(h=20,r=holdrod_radius+holdrod_wall,chamfer1=1,chamfer2=0);
    cuboid(size=body, rounding=8);
  }
  bearings();
  spinrod(r=spinrod_radius);
  holdrod(r=holdrod_radius);
}

module holdrod (r) { zmove(-15) xrot(-angle) ymove(body.z/2) ycyl(r=r,h=body.z); }
module spinrod (r) { xcyl(r=r,h=50); }
module bearings() {
  hull()
    xmove(bearing_height) xscale(2) yrot(90)
    bearing(dt=delta);
}
