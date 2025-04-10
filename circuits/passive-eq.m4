.PS
#
# Passive Equalizer
#
cct_init
dim = 0.9

#
# Horizontal
#
dot; llabel("in"); line right dim/2
C1: line dim; capacitor(dim); llabel(,102)
R1: variable(resistor(dim)); llabel(,B100k,)
C2: capacitor(dim); llabel(,102)
ground

#
# Vertical
#
move to C1.start
R2: resistor(down_ dim); rlabel(,10k,)
R3: variable(resistor(down_ dim)); rlabel(,B100k)
R4: resistor(down_ dim); rlabel(,430)
ground

#
# Horizontal 2
#
line <- right_ dim from R3
R5: dot; resistor(dim); llabel(,10k); line dim/2
{ line -> to R1 } # |
C3: dot; capacitor(,C); llabel(,2.2)
R6:      variable(resistor); llabel(,A100k)
{ line from R6.center down_ dim then right_ dim/3; dot; rlabel(,,"out") }
         ground

#
# Parallel
#
C4: capacitor(right_ dim at (2/5 between R2 and R3) + (dim/2,0) ); llabel(,102)
R7: resistor(right_ dim at (3/5 between R2 and R3) + (dim/2,0) ); rlabel(,100k)
line from C4.end to R5
C5: capacitor(down_ dim/2); rlabel(,104)
line left_ dim; dot

.PE
