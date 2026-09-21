include <./parts/smoothrod_groved.scad>;
include <./parts/spool.scad>;
include <./parts/frame.scad>;
include <./parts/holder.scad>;
include <./parts/spinner.scad>;

width        = 40;
angle        = 80;
thickness    = 11;
lip_top      = 2;
lip_bottom   = 0.6;
magic_number = 12;
error        = 0.2;
separation   = 120;

if ($preview) {
  back(-20) up(150) {
    color("silver")
      xcyl(h=300,r=4);
    left(separation/2)
      xrot(-90+10) yrot(90)
      spinner();
    right(separation/2)
      xrot(90+10) yrot(-90)
      spinner();
  }

  frame();
  // Hold - LEFT
  translate([separation/2,0,0]) holder(lip_bottom = lip_bottom, lip_top = lip_top, thickness = thickness, angle = angle, width = width, frame=frame, error = error);
  rotate([90-angle,0,0]) translate([separation/2,-magic_number,0])
    smoothrod_groved();
  // Hold - RIGHT
  translate([-separation/2,0,0]) holder(lip_bottom = lip_bottom, lip_top = lip_top, thickness = thickness, angle = angle, width = width, frame=frame, error = error);
  rotate([90-angle,0,0]) translate([-separation/2,-magic_number,0])
    smoothrod_groved();
  // Spool
  translate([0, -20, spool_diameter/2 + thickness + frame.z/2 + 5])
    rotate([90,0,90])
    spool();
} else {
  $fn=200;
  rotate([0,90,0])
    holder(lip_bottom = lip_bottom, lip_top = lip_top, thickness = thickness, angle = angle, width = width, frame=frame, error = error);
}

