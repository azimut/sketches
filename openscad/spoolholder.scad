include <./parts/smoothrod_groved.scad>;
include <./parts/spool.scad>;

frame = [100, 9.4, 50.4]; // 370
frame();

rod_bottom    = 45;
rod_angle     = 15;
wideness      = 20;
thickness     =  8;
bite_uheight  = 10;
bite_lheight  =  0;
spool_offset  = 10;

translate([0,0,frame.z/2 + thickness])
  rotate([rod_angle,0,0])
    smoothrod_groved();


translate([-spool_height/2,
           -spool_diameter/5,
           spool_diameter/2 + frame.z/2 + thickness + rod_bottom + spool_offset])
rotate([0,90,0])
spool();

translate([-wideness/2,-thickness-frame.y/2])
rotate([90,0,90])
linear_extrude(wideness)
offset(2)
union() {
  polygon([[0                    ,  frame.z/2 + thickness] + rod_bottom*indir(90+rod_angle),
           [0                    ,  frame.z/2 + thickness],
           [0                    , -frame.z/2 - thickness]]);
  polygon([[0                    ,-(frame.z/2 + thickness)],
           [0                    , frame.z/2 + thickness],
           [0                    , frame.z/2 + thickness] + rod_bottom*indir(90+rod_angle),
           [thickness*2 + frame.y, frame.z/2 + thickness] + rod_bottom*indir(90+rod_angle),
           [thickness*2 + frame.y, frame.z/2 + thickness],
           [0                    , frame.z/2 + thickness]]);

  for (i = [0,1])
    mirror([0,i,0])
      polygon([[0                    , 0],
               [0                    , frame.z/2 + thickness],
               [thickness*2 + frame.y, frame.z/2 + thickness],
               [thickness*2 + frame.y, frame.z/2 - ((i==0) ? bite_uheight : bite_lheight) ],
               [thickness   + frame.y, frame.z/2 - ((i==0) ? bite_uheight : bite_lheight) ],
               [thickness   + frame.y, frame.z/2],
               [thickness            , frame.z/2],
               [thickness            , 0]]);

}

// %difference(){
//   shape1();
//   frame();
// }

function indir(angle) = [cos(angle),sin(angle)];

module frame() {
  color("#c19a6b")
  cube(frame, center=true);
}

module shape1 () {
  hull() {
    translate([0,0,15]) cube([20,30,80], center=true);
    translate([0,-25,30])
      rotate([45,0,0])
      cube([20,30,70],center=true);
  }
}

module shape2() {
  difference() {
    shape1();
    translate([50,-73,-8])
      rotate([180,90,0])
      color("green")
      linear_extrude(100)
      circle(60);
  }
}
