include <./smoothrod_groved.scad>;
include <./bearing.scad>
include <BOSL2/std.scad>
include <BOSL2/rounding.scad>

delta = 0.2;
spinner_body_radius = 15;
spinner_body_height = 15;
spinner_tube_height = 50;
spinner_tube_radius = 8;
spinner_tube_extra_offset = -3;

module spinner() {
  difference() {
    union() {
      rawspinner(th=spinner_tube_height,
                 tr=spinner_tube_radius,
                 br=spinner_body_radius,
                 bh=spinner_body_height,
                 textra=spinner_tube_extra_offset,
                 delta=delta);

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

        scale([0.9,0.9,1])
          down(spinner_tube_radius + 2.5)
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
    spinrod(r=4);
    holdrod(extra=spinner_tube_extra_offset);
    bearings(dt=delta);
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
