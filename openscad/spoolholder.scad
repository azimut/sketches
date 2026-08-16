include <./parts/smoothrod_groved.scad>;
translate([0,0,30]) rotate([45,0,0]) smoothrod_groved();


// ideas: inverted pyramid, +arcs, circles cuts on angle

frame = [370, 9.4, 50.4];

#frame();

wideness       = 20;
thickness      = 5;
bite_height    = 7;

%translate([-wideness/2,-thickness-frame.y/2])
rotate([90,0,90])
linear_extrude(wideness)
offset(1)
union() {
  polygon([[0                    ,-(frame.z/2 + thickness)],
           [0                    , frame.z/2 + thickness],
           [0                    , frame.z/2 + thickness]   + [-30,30],
           [thickness*2 + frame.y, frame.z/2 + thickness]   + [-30,30],
           [thickness*2 + frame.y, frame.z/2 + thickness],
           [0                    , frame.z/2 + thickness]]);

  for (i = [0,1])
    mirror([0,i,0])
      polygon([[0                    , 0],
               [0                    , frame.z/2 + thickness],
               [thickness*2 + frame.y, frame.z/2 + thickness],
               [thickness*2 + frame.y, frame.z/2 + thickness - bite_height ],
               [thickness   + frame.y, frame.z/2 + thickness - bite_height ],
               [thickness   + frame.y, frame.z/2],
               [thickness            , frame.z/2],
               [thickness            , 0]]);

}

// %difference(){
//   shape1();
//   frame();
// }

module frame() {
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
