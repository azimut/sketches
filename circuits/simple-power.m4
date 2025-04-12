.PS
cct_init
dim = 0.9

#
# Top Horizontal + components going down
#
corner(, at Here)
ground;
R1: resistor(right_ dim); llabel(,22k);
{ capacitor(down_ dim/2, C); llabel(,\SI{10}{\micro\farad}); ground(,T) }
dot; line right_ dim; dot
{ R2: resistor(down_ dim); llabel(,22k) }
  R3: resistor(right_ dim); llabel(,22k)
{ line up dim/3; dot; llabel("$V_{cc}$") }
{ dot; capacitor(right_ dim); llabel(,104)
  corner; ground }
{   line down dim/2
    dot; capacitor(right_ dim,C); llabel(,\SI{100}{\micro\farad}); corner; ground
L1: line down dim/2 from 2nd last []
}

#
# OPAMP In1 leg
#
OP: opamp(dim,,,,R) with .E1 at L1.end; clabel("TDA1875T")
line from OP.In1 to R2.end
dot; capacitor(left_ dim); rlabel(,\SI{1}{\micro\farad})
dot; { line left dim/3; dot; rlabel(,"$V_{in}$") }
resistor(down_ dim*0.75); llabel(,1M)
ground(,T)

line from OP.E2 down_ dim/4; ground(,T) # OPAMP E2 leg

#
# OPAMP In2 leg
#
line left_ dim/2 then down_ dim from OP.In2
dot
{ resistor(left_ dim); rlabel(,10k)
  capacitor(left_ dim,C); rlabel(,\SI{10}{\micro\farad}); corner
  ground;} # <-
R4: resistor(right_ dim); llabel(,220k)

#
# OPAMP output leg
#
line right (OP.e.x - R4.end.x) then up (OP.E.y - R4.y)
dot
capacitor(right_ dim, C); llabel(,\SI{2200}{\micro\farad})
speaker(,dim/2); llabel(,\SI{8}{\Omega})
line from last [] .In7 down
ground(,T)

.PE
