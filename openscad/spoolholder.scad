include <./parts/smoothrod_groved.scad>;
include <./parts/spool.scad>;
include <./parts/frame.scad>;

rod_bottom    = 0;
rod_angle     = 10;
wideness      = 20;
thickness     =  8;
bite_uheight  = 10;
bite_lheight  =  0;
spool_offset  = 10;

if ($preview) {
  frame();
  rod();

  translate([-spool_height/2,
             -spool_diameter/5,
             spool_diameter/2
               + frame.z/2
               + thickness
               + rod_bottom
               + spool_offset])
    rotate([0,90,0])
    spool();
  %holder();
} else {
  difference(){
    holder();
    rod();
    frame();
  }
}


function indir(angle) = [cos(angle),sin(angle)];



module holder_tall() {
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
}


module holder() {
  translate([-wideness/2,-thickness-frame.y/2])
    rotate([90,0,90])
    linear_extrude(wideness)
    offset(1)
    union() {
    polygon([[-20                  ,  frame.z/2 + thickness],
             [0                    ,  frame.z/2 + thickness],
             [0                    , -frame.z/2 - thickness]]);
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
}

module rod () {
  //translate([0,0,frame.z/2 + thickness])
  translate([0,-10,-6])
    rotate([rod_angle,0,0])
    smoothrod_groved();
}
