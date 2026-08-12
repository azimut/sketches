grosor        = 10;
size          = 100;
altura        = 30;
altura_solapa = altura + altura*0.2;
redondeo      = 15;


difference() {
  union() {
    linear_extrude(altura)
      offset(redondeo)
      square(size-redondeo*2, center=true);
    linear_extrude(altura_solapa)
      offset(redondeo)
      square(size-(altura_solapa-altura)-redondeo*2,
             center=true);
  }
  translate([0,0,grosor])
    linear_extrude(altura_solapa + altura*0.1)
    offset(redondeo)
    square(size-grosor-grosor-redondeo*2,
           center=true);
}
