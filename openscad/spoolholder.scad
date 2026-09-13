include <./parts/smoothrod_groved.scad>;
include <./parts/spool.scad>;
include <./parts/frame.scad>;
include <./parts/holder.scad>;

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

