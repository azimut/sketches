// 1k spool

disk_diameter = 217;
disk_height   =   6;
tube_diameter =  76;
tube_height   =  60;
hole_diameter =  26;

spool_diameter = disk_diameter;
spool_height   = disk_height*2 + tube_height;

module spool () {
  color("crimson")
    union() {
      translate([0,0,-tube_height/2]) spool_disk();
      spool_tube();
      translate([0,0, tube_height/2]) spool_disk();
    }
}

module spool_tube () {
  difference() {
    cylinder(d=tube_diameter, h=tube_height,   center=true);
    cylinder(d=hole_diameter, h=tube_height*2, center=true);
  }
}

module spool_disk() {
  difference() {
    cylinder(d=disk_diameter,h=disk_height,center=true);
    cylinder(h=disk_height*2,d=hole_diameter,center=true);
  }
}
