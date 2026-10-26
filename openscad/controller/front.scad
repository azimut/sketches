include <BOSL2/std.scad>
include <./parts/buttonh.scad>
include <./parts/pcbd.scad>

body_size = 56;
body_rounding = 10;
body = [body_size,body_size,14.6];

wedge_height = 6;
wedge_thickness = 3;
atras_wall_thickness = 3;
atras_pocket_height = atras_wall_thickness + 2;
outer_wedge_thickness = 2;

module atras(dt=0) {
  difference() {
    // base
    cuboid([body_size,
            body_size,
            atras_wall_thickness + atras_pocket_height],
           rounding=body_rounding, edges="Z", anchor=BOTTOM)
      position(TOP)
      // wedge
      cuboid(size=[body_size - outer_wedge_thickness*2 + dt,
                   body_size - outer_wedge_thickness*2 + dt,
                   wedge_height + dt],
             rounding=body_rounding,
             edges="Z",
             anchor=BOTTOM);
    // pocket - aka wedge cutout
    up(atras_wall_thickness + 0.02)
      cuboid(size=[body_size - outer_wedge_thickness*2 - wedge_thickness*2 + dt,
                   body_size - outer_wedge_thickness*2 - wedge_thickness*2 + dt,
                   wedge_height + 5 + dt],
             rounding=body_rounding,
             edges="Z",
             anchor=BOTTOM);
  }
}

frente();
//pcb();
//atras(dt=-0.2);
 up(14-10/2) up(body.z) yrot(180)  atras();

module frente() {
  difference() {
    intersection() {
      difference() {
        cuboid(body, anchor=BOTTOM, rounding=body_rounding, edges="Z");
        zscale(20) buttons(pad_middle=-0.01, dt=0.3);
        up(3)
          cuboid([buttonh.x*2+4,buttonh.y+4,13],
                 anchor=BOTTOM,
                 rounding=1,
                 edges="Z");
      }
      difference() {
        cuboid(body, anchor=BOTTOM, chamfer=2, edges=BOTTOM);
        zscale(20) buttons(pad_middle=-0.01, dt=0.3);
        up(3)
          cuboid([buttonh.x*2+4,buttonh.y+4,13],
                 anchor=BOTTOM,
                 rounding=1,
                 edges="Z");
      }
    }
    pcb();
    up(14.62)
      rect_tube(size=body.x-2*2, wall=wedge_thickness, h=wedge_height,
                rounding=body_rounding,
                anchor=TOP);
  }
// pcb();
// buttons(zoff=-2);
}
module buttons(pad_middle = 0.1, dt=0, zoff=0) {
  up(buttonh.z - 0.001 + zoff) xrot(180) { // -2
    left(buttonh.x/2  + pad_middle) buttonh(dt);
    right(buttonh.x/2 + pad_middle) buttonh(dt);
  }
}
module pcb() {
  down(3.7) back(6) left(3.7) up(20) xrot(180)
    pcbd();
}
