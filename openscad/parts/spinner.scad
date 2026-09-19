include <./bearing.scad>
include <BOSL2/std.scad>

body = [20,30,30];
epsilon = 0.001;
delta = 0.2;
holdrod_radius = 4;
holdrod_wall = 3;
spinrod_radius = bearing_idiameter/2 + epsilon;
angle = 20;
hold_distance = [0,-body.y/2,-15];
hold_height = 50;

difference() {
  hull() {
    xrot(angle) cuboid(size=body, rounding=8);
    move(hold_distance) xrot(angle) cyl(h=hold_height,r=holdrod_radius+holdrod_wall,chamfer1=1,chamfer2=0);
  }
  bearings();
  spinrod(r=spinrod_radius);
  holdrod(r=holdrod_radius);
}

module holdrod (r) { move(hold_distance) xrot(270+angle) ymove(body.z/2) ycyl(r=r,h=hold_height*2); }
module spinrod (r) { xcyl(r=r,h=50); }
module bearings() {
  hull()
    xmove(bearing_height) xscale(2) yrot(90)
    bearing(dt=delta);
}
