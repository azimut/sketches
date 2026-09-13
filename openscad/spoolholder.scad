include <./parts/smoothrod_groved.scad>;
include <./parts/spool.scad>;
include <./parts/frame.scad>;
include <Round-Anything/polyround.scad>;

width        = 40;
angle        = 80;
thickness    = 11;
lip_top      = 2;
lip_bottom   = 0.6;
magic_number = 12;
error        = 0.2;

if ($preview) {
  frame();
  holder(lip_bottom = lip_bottom, lip_top = lip_top, thickness = thickness, angle = angle, width = width, frame=frame, error = error);
  rotate([90-angle,0,0]) translate([0,-magic_number,0])
    smoothrod_groved();
  translate([0, -40, spool_diameter/2 + thickness + frame.z/2 + 10])
    rotate([90,0,90])
    spool();
} else {
  $fn=200;
  rotate([90,0,0])
    holder(lip_bottom = lip_bottom, lip_top = lip_top, thickness = thickness, angle = angle, width = width, frame=frame, error = error);
}

module holder (angle,width,thickness,lip_bottom,lip_top, frame, error = 0) {
  let (frame = frame + [0,error,error])
    difference() {
    translate([-width/4,0,0])
      rotate([90,0,90])
      translate([-frame.y/2,-frame.z/2,0])
      polyRoundExtrude(holder_silloute(lip_bottom = lip_bottom, lip_top = lip_top, thickness = thickness, angle = angle, frame = frame),
                       width/2,
                       0.75,
                       0.75);
    rotate([90-angle,0,0])
      translate([0,-magic_number,0])
      smoothrod_groved();
  }
}

function holder_silloute (thickness = 10, lip_top = 4, lip_bottom = 2, radius = 3, angle = 45, frame, error = 0) =
  let (delta  = ((thickness * 2 + frame.z) / tan(angle)))
  [[0                , 0                , 0],
   [0                , frame.z          , 0],
   [frame.y          , frame.z          , 0],
   [frame.y          , frame.z - lip_top, 0],
   [frame.y+thickness, frame.z - lip_top, radius],
   [frame.y+thickness, frame.z+thickness, radius],
   [-thickness-delta , frame.z+thickness, radius * 2],
   [-thickness       , -thickness       , radius * 4],
   [frame.y+thickness, -thickness       , radius],
   [frame.y+thickness, lip_bottom       , radius],
   [frame.y          , lip_bottom       , 0],
   [frame.y          , 0                , 0]];
