include <./smoothrod_groved.scad>;
include <./bearing.scad>
include <BOSL2/std.scad>
include <BOSL2/rounding.scad>

delta = 0.2;
spinner_body_radius = 15;
spinner_body_height = 15;
spinner_tube_height = 50;
spinner_tube_radius = 7.5;
spinner_tube_extra_offset = -3;
spinner_holder_rod_radius = 4 + 2;

module spinner() {
  difference () {
    translate([spinner_body_radius+1.25,0,spinner_tube_radius-4]) linear_extrude(4.5) {
      text("8", size=9, valign="center", halign="center");
      zrot(90) text("/", size=9, valign="center", halign="center");
      zrot(90) text("O", size=10, valign="center", halign="center");
    }
    holdrod(extra=spinner_tube_extra_offset);
  }
  difference() {
    union() {
      rawspinner(th=spinner_tube_height,
                 tr=spinner_tube_radius,
                 br=spinner_body_radius,
                 bh=spinner_body_height,
                 textra=spinner_tube_extra_offset,
                 delta=delta);
      // Chamfer
      hull(){
        down(spinner_tube_radius)
          up(-0.0003)
          linear_extrude(spinner_tube_radius)
          projection()
          rawspinner(th=spinner_tube_height,
                     tr=spinner_tube_radius,
                     br=spinner_body_radius,
                     bh=spinner_body_height,
                     textra=spinner_tube_extra_offset,
                     delta=delta);

        scale([0.974,0.97,1])
          down(spinner_tube_radius + 0.8)
          up(-0.0003)
          linear_extrude(spinner_tube_radius)
          projection()
          rawspinner(th=spinner_tube_height,
                     tr=spinner_tube_radius,
                     br=spinner_body_radius,
                     bh=spinner_body_height,
                     textra=spinner_tube_extra_offset,
                     delta=delta);
      }
    }
    spinrod(r=spinner_holder_rod_radius);
    bearings(dt=delta);
    holdrod(extra=spinner_tube_extra_offset);
  }

}

module rawspinner(th,tr,br,bh,textra=0,delta=0) {
  hull() {
    spinner_tube(r=tr, h=th, extra=textra);
    zcyl(r=br, h=bh, rounding=5);
  }
}

module spinner_tube(r,h,extra=0) {
  xmove(bearing_diameter/2 + spinner_tube_radius + extra)
    ycyl(h=h,r=r,rounding=5);
}

module holdrod (extra=0) {
  right(bearing_diameter/2+spinner_tube_radius + extra)
    back(100)
    xrot(90)
    smoothrod_groved(dt=delta); }
module spinrod (r) { zcyl(r=r,h=50); }
module bearings(dt=dt) {
  hull()
    zmove(bearing_height) zscale(2)
    bearing(dt=dt);
}
