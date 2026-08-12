epsilon = 0.1;

idle_radius =  10;
idle_width  = 100;
idle_depth  =  50;
idle_height =  35;

stepper_height            = 15;
stepper_radius            = 20;
stepper_screw_hole_radius = 1;
stepper_screw_flap_height = 2;
stepper_screw_flap_radius = stepper_screw_hole_radius+1.5;
stepper_gear_radius       = 4;
stepper_gear_height       = 4;



// idler();
// motor_height =
//   idle_height
//   - stepper_height
//   + stepper_screw_flap_height
//   + epsilon;
// translate([-5, 0, motor_height])
//   rotate(-45)
//     stepper();


stepper();
translate([-stepper_radius,-stepper_radius,-stepper_height*1/5])
  rotate([0,0,-45])
    cube([10,2,stepper_height+stepper_height*1/5]);

module stepper() {
  color("gold")
    translate([0,0,stepper_height])
      cylinder(r=stepper_gear_radius, h=stepper_gear_height);
  color("silver") {
    cylinder(r=stepper_radius, h=stepper_height);
    translate([stepper_radius+stepper_screw_flap_radius/2,
               0,
               stepper_height-stepper_screw_flap_height])
      stepper_flap();
    translate([-stepper_radius-stepper_screw_flap_radius/2,
               0,
               stepper_height-stepper_screw_flap_height])
      stepper_flap();
  }
}

module stepper_flap() {
  difference() {
    cylinder(r=stepper_screw_flap_radius,
             h=stepper_screw_flap_height);
    cylinder(r=stepper_screw_hole_radius,
             h=stepper_screw_flap_height*4,
             center=true);
  }
}

module idler() {
   difference() {
     linear_extrude(idle_height, $fn=10)
       offset(5)
         circle(40,$fn=3);
     for (a=[45,180,315]) {
       translate([0,0,-5])
         rotate(a)
           rotate(90,[0,1,0])
           cylinder(r=20,h=50,$fn=10);
     }
   }
}
