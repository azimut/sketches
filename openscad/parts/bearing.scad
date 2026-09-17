bearing_diameter  = 22;
bearing_height    = 7;
bearing_idiameter = 8;

module bearing(d=bearing_diameter, h=bearing_height, id=bearing_idiameter, dt=0, $fn=30) {
  difference() {
    cylinder(d =  d + dt, h = h  , center = true, $fn=$fn);
    cylinder(d = id     , h = h*2, center = true, $fn=$fn);
  }
}
