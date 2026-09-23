include <./parts/smoothrod_groved.scad>;
include <./parts/spool.scad>;
include <./parts/frame.scad>;
include <./parts/holder.scad>;
include <./parts/spinner.scad>;

angle        = 80;
thickness    = 11;
magic_number = 12;
error        = 0.2;
separation   = 120;

show_lholder = true;
show_rholder = true;
show_spinner = true;

if ($preview) {
  $fn=200;
  frame();
  back(-23) up(spool_diameter/2 + thickness + frame.z/2 + 5) {
    // Spool
    rotate([90,0,90])
      spool();
    // Spinnner
    color("silver") xcyl(h=300,r=4);
    right(separation/2)
      xrot(-90+10) yrot(90)
      spinner();
    left(separation/2)
      xrot(+90+10) yrot(-90)
      spinner();
  }
  // Hold - LEFT
  translate([separation/2,0,0]) rotate([90,0,90]) holder(rl=4,rr=0.4,error=error);
  rotate([90-angle,0,0]) translate([separation/2,-magic_number,0])
    smoothrod_groved();
  // Hold - RIGHT
  translate([-separation/2,0,0]) rotate([90,0,90]) holder(rr=4,rl=0.4,error=error);
  rotate([90-angle,0,0]) translate([-separation/2,-magic_number,0])
    smoothrod_groved();
} else {
  $fn=200;
  if(show_lholder) translate([0,0,width/2]) rotate([0,0,0])   holder(rl=4, rr=0.4, error=error);
  if(show_rholder) translate([0,0,width/2]) rotate([180,0,0]) holder(rr=4, rl=0.4, error=error);
  if(show_spinner) translate([0,0,spinner_body_height/2+0.8]) spinner();
}

