epsilon = 0.1;

barilla_longitud = 300;
barilla_radio    =  10;

idle_radius =  10;
idle_width  = 100;
idle_depth  =  50;
idle_height = 100;

idle_cut_radius = idle_width/3;

motor_diameter = 10;
motor_height   = 10;

motor();
idle();

module motor() {
  color("gray")
    cylinder(r=motor_diameter/2,
             h=motor_height)  ;
}

module idle() {
  difference() {
    idle_body();
    translate([-idle_width/3,0,idle_height/2])
      barilla();
    translate([ idle_width/3,0,idle_height/2])
      barilla();
  }
}

module idle_body() {
  difference() {
    linear_extrude(idle_height)
      offset(r=idle_radius)
        square([idle_width-(idle_radius*2),
                idle_depth-(idle_radius*2)],
               center=true);
    translate([0,-idle_cut_radius - idle_depth/4,-epsilon])
      linear_extrude(idle_height + epsilon*2)
        circle(r=idle_cut_radius);
    translate([0, idle_cut_radius + idle_depth/4,-epsilon])
      linear_extrude(idle_height + epsilon*2)
        circle(r=idle_cut_radius);
  }
}

module barilla() {
  rotate([90,0,0])
    linear_extrude(barilla_longitud, center=true)
      circle(barilla_radio, $fn=15);
}
