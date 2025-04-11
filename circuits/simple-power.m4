.PS
cct_init
dim = 0.9

#
# Top Horizontal + components going down
#
ground
R1: resistor(right_ dim)
{ capacitor(down_ dim/2); ground }
dot; line right_ dim
{ R2: resistor(down_ dim) }
  R3: resistor(right_ dim)
{ L1: line down dim }
dot; capacitor;
corner; ground

#
# OPAMP In1 leg
#
OP: opamp(dim) with .E1 at L1.end
line from OP.In1 to R2.end
dot; capacitor(left_ dim);
dot; { line left dim/3; dot; rlabel(,"Vin") }
resistor(down_ dim*0.75)
ground(,T)

line from OP.E2 down_ dim/4; ground(,T) # OPAMP E2 leg

#
# OPAMP In2 leg
#
line left_ dim/2 then down_ dim from OP.In2
dot
{ resistor(left_ dim); capacitor(left_ dim); ground } # <-
R4: resistor(right_ dim)

#
# OPAMP output leg
#
line right (OP.e.x - R4.end.x) then up (OP.E.y - R4.y)
dot
capacitor(right_)
SP: speaker(,dim/2)
line from SP.In7 down
ground(,T)

.PE
