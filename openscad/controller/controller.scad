include <BOSL2/std.scad>

include <./pieces.scad>

epsilon              = 0.01;
body_rounding        = 20;
body                 = [100,50,2.75];
pcbchomp             = pcbd.z - 0.1;
body_wedge_height    = zpcbseparation - pcbo.z + 0.2;
body_wedge_thickness = 2;
zseparation          = buttonh.z - buttonh_wedge.z - body.z; // body to adjust buttons

module frontside() {
  difference() {
    // body
    up(zseparation)
      snes(h=body.z+body_wedge_height, r=body.y/2+2, xsep=24);
    // wedge cutout
    up(zseparation + body.z + epsilon)
      snes(h=body_wedge_height + epsilon, r=body.y/2+2 - 1.5*2, xsep=24);
    // pieces
    pieces(dt=0.3, pad_middle=0);
  }
}

module backside() {
  difference() {
    union() {
      // wedge
      up(zseparation + body.z + body_wedge_height - 5)
        snes(h=5,r=body.y/2+2 - 1.5*2 - 0.2,xsep=24);
      // base
      color("violet")
        up(zseparation + body.z + body_wedge_height)
        snes(h=body.z,r=body.y/2+2,xsep=24);
    }
    // pcb cutoutn
    pieces(dt=0.3, switches=false);
    // pcb screws
    down(1) pieces(dt=0.3);
  }
}

show_frontside = true;
show_backside  = true;
show_pieces    = true;

$fn = $preview ? 30 : 100;

if (show_frontside) frontside();
if (show_backside)  backside();
if (show_pieces)    pieces(pad_middle=0.1,dt=0);

module snes(h=10,r=13,xsep=17,ratio=0.15) {
  fwd(4) {
    cuboid([xsep*2,r*(1-ratio)*2,h],anchor=BOTTOM);
    back(r*ratio) left(xsep)  zcyl(r=r,h=h,anchor=BOTTOM);
    back(r*ratio) right(xsep) zcyl(r=r,h=h,anchor=BOTTOM);
  }
}
