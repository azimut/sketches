include <BOSL2/std.scad>

include <./pieces.scad>

dt                   = 0.3;
body_rounding        = 20;
body                 = [100,50,3];
pcbchomp             = pcbd.z - 0.1;
body_wedge_height    = zpcbseparation - pcbchomp;
body_wedge_thickness = 2;
zseparation          = buttonh.z - buttonh_wedge.z - body.z; // body to adjust buttons

module frontside() {
  difference() {
    // body
    up(zseparation) up(0.01) {
      // base
      #cuboid(body, rounding=body_rounding, edges="Z", anchor=BOTTOM);
      // wedge
      up(body.z + 0.003) {
        difference() {
          color("pink")
            cuboid([body.x,body.y,body_wedge_height],
                   rounding=body_rounding, edges="Z",
                   anchor=BOTTOM);
          cuboid([body.x-body_wedge_thickness*2,
                  body.y-body_wedge_thickness*2,
                  body_wedge_height*3],
                 rounding=body_rounding, edges="Z");
        }
      }
    }
    pieces(dt=0.3, pad_middle=0);
  }
}

module backside() {
  difference() {
    up(zpcbseparation-pcbchomp)
      // wedge
      cuboid([body.x-body_wedge_thickness*2 - dt*2,
              body.y-body_wedge_thickness*2 - dt*2,
              5],
             anchor=BOTTOM,
             rounding=body_rounding,
             edges="Z")
      // base
      color("violet")
      position(TOP)
      cuboid([body.x,body.y,3],
             rounding=body_rounding, anchor=BOTTOM, edges="Z");
    // pcb screws
    //down(1) pieces(dt=0.2);
    // pcb cutout
    up(pcbchomp) pieces(dt=0.2);
  }
}

show_frontside = false;
show_backside  = true;
show_pieces    = false;

$fn = $preview ? 30 : 100;

if (show_frontside) frontside();
if (show_backside)  backside();
if (show_pieces)    pieces(pad_middle=0.1);
