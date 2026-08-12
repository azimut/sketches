translate([0,0,-30])
difference() {
  mango();
  grip(n=8,r=3);
  hole(r=3);
}

module hole(r=3) {
  translate([0,0,51]) cylinder(h=10,r=r,$fn=5);
}

module grip(n=8,r=3) {
  for (i = [0:(360/n):360])
      rotate([0,0,i])
        translate([0,12,0])
          cylinder(h=200,r=r,center=true);
}

module mango() {
  cylinder(h=10,r1=7,r2=10);
  translate([0,0,10]) cylinder(h=40,r=10);
  translate([0,0,40+10]) cylinder(h=10,r1=10,r2=7);
}
