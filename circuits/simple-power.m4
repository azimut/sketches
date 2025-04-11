.PS
cct_init
dim = 0.9

#
# Top Horizontal + components going down
#
corner(, at Here)
ground;
R1: resistor(right_ dim); llabel(,22k);
{ capacitor(down_ dim/2, C); llabel(,10uf); ground(,T) }
dot; line right_ dim; dot
{ R2: resistor(down_ dim); llabel(,22k) }
  R3: resistor(right_ dim); llabel(,22k)
{ L1: line down dim }
dot; capacitor; llabel(,1uf)
corner; ground

#
# OPAMP In1 leg
#
OP: opamp(dim) with .E1 at L1.end
line from OP.In1 to R2.end
dot; capacitor(left_ dim); rlabel(,1Mf)
dot; { line left dim/3; dot; rlabel(,"Vin") }
resistor(down_ dim*0.75); llabel(,1M)
ground(,T)

line from OP.E2 down_ dim/4; ground(,T) # OPAMP E2 leg

#
# OPAMP In2 leg
#
line left_ dim/2 then down_ dim from OP.In2
dot
{ resistor(left_ dim); rlabel(,10k)
  capacitor(left_ dim); rlabel(,10uf); corner
  ground;} # <-
R4: resistor(right_ dim); llabel(,200k)

#
# OPAMP output leg
#
line right (OP.e.x - R4.end.x) then up (OP.E.y - R4.y)
dot
capacitor(right_ dim, C); llabel(,2200uf)
speaker(,dim/2); llabel(,928)
line from last [] .In7 down
ground(,T)

.PE
