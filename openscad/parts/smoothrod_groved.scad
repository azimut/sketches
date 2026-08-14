// down(220.5/2) smoothrod_groved(bh=220.5);

// Smoothrod from a HP printer that originally comes with plastic black disks for the stuck paper
module smoothrod_groved(el1h=1,   el1d1=3, el1d2=5,
                        el2h=1.7, el2d=5,
                        el3h=8.5, el3d=5.4,
                        el4h=1,
                        el5h=1,
                        el6h=11.5, el6d=6,
                        bh=220.2,bd=8,
                        es1d=6,es1h=10.5,
                        es2d=4.5,es2h=3,
                        es3d1=5.5,es3d2=4,es3h=1.5) {
  // Longer thinner end
                               cylinder(h=el1h, r1=el1d1/2, r2=el1d2/2);
  up(el1h)                     cylinder(h=el2h, d=el2d);
  up(el1h+el2h)                cylinder(h=el3h, d=el3d);
  up(el1h+el2h+el3h)           cylinder(h=el4h, d=el2d);
  up(el1h+el2h+el3h+el4h)      cylinder(h=el5h, r1=el2d/2, r2=el6d/2);
  up(el1h+el2h+el3h+el4h+el5h) cylinder(h=el6h, d=el6d);
  // Body
  elh = el1h+el2h+el3h+el4h+el5h+el6h;
  up(elh)              cylinder(h=bh,d=bd);
  // Short thicker end
  up(elh+bh)           cylinder(h=es1h, d=es1d);
  up(elh+bh+es1h)      cylinder(h=es2h, d=es2d);
  up(elh+bh+es1h+es2h) cylinder(h=es3h, r1=es3d1/2, r2=es3d2/2);
}

module up(by) { translate([0,0,by]) { children(); } }
module down(by) { translate([0,0,-by]) { children(); } }
