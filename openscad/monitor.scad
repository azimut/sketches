body = [600,30,400];
body_screen_offset = [50,-50,50];
body_angle = 30; // USE!!
hole = [body.x*0.8,300,10];

color("silver")
monitor();

module monitor() {
  body();
  difference() {
    union() {
      ramp();
      difference() {
        mirror([0,0,1]) ramp();
        translate([0, body.y/2, body.z/2 * 0.9])
          cube(hole, center = true);
      }
    }
    translate([0,500,0]) cube(700,center=true);
  }
}

module body() {
  difference() {
    cube(body, center = true);
    translate([0,-body.y,0])
      cube(body-body_screen_offset , center=true);
  }
}

module ramp() {
  points = [[0,body.x/2],[0,0],[body.z/2,0]];
  translate([-body.x/2,body.y/2,0])
    rotate([0,90,0])
    linear_extrude(body.x)
    polygon(points);
}
