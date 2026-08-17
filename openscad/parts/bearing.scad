module bearing(d=22, h=7, id=8, $fn=30) {
  difference() {
    cylinder(d =  d, h = h  , center = true, $fn=$fn);
    cylinder(d = id, h = h*2, center = true, $fn=$fn);
  }
}
