include <./parts/smoothrod_groved.scad>;
include <./parts/spool.scad>;
include <./parts/frame.scad>;
include <Round-Anything/polyround.scad>;

width = 50;
angle = 80;
thickness = 14;
lip_bottom = 1;
magic_number = 15;

if ($preview) {
  holder(lip_bottom = lip_bottom, thickness = thickness, angle = angle, width = width);
  frame();
  rotate([90-angle,0,0]) translate([0,-magic_number,0]) smoothrod_groved();
  translate([0, -40, spool_diameter/2 + thickness + frame.z/2 + 10])
    rotate([90,0,90]) spool();
} else {
  rotate([0,90,0])
  holder(lip_bottom = lip_bottom, thickness = thickness, angle = angle, width = width);
}

module holder (angle,width,thickness,lip_bottom,lip_top) {
  difference() {
    translate([-width/4,0,0])
      rotate([90,0,90])
      extrudeWithRadius(width/2,0.5,0.5,3)
      translate([-frame.y/2,-frame.z/2,0])
      holder_silloute(lip_bottom = 1, thickness = thickness, angle = angle);
    rotate([90-angle,0,0]) translate([0,-magic_number,0]) smoothrod_groved();
  }
}

module holder_silloute (thickness = 10, lip_top = 4, lip_bottom = 2, radius = 3, angle = 45) {
  delta  = (thickness * 2 + frame.z) / tan(angle);
  points = [
            [0                , 0                , 0],
            [0                , frame.z          , 0],
            [frame.y          , frame.z          , 0],
            [frame.y          , frame.z - lip_top, 0],
            [frame.y+thickness, frame.z - lip_top, radius],
            [frame.y+thickness, frame.z+thickness, radius],
            [-thickness-delta , frame.z+thickness, radius * 1],
            [-thickness       , -thickness       , radius * 3],
            [frame.y+thickness, -thickness       , radius],
            [frame.y+thickness, lip_bottom       , radius],
            [frame.y          , lip_bottom       , 0],
            [frame.y,         , 0                , 0]
            ];
  polygon(polyRound(points, 30));
}
