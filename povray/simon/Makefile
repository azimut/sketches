NAME   := board
WIDTH  ?= 300
HEIGHT ?= 300
OPTS   += +W$(WIDTH) +H$(HEIGHT)
OPTS   += +Q11 +A0.2 +UA

$(NAME).png: $(NAME).pov
	povray Declare=BL=0 Declare=GL=0 Declare=RL=0 Declare=YL=0 $(OPTS) $<
	povray Declare=BL=1 Declare=GL=0 Declare=RL=0 Declare=YL=0 $(OPTS) +Oblue.png    $<
	povray Declare=BL=0 Declare=GL=1 Declare=RL=0 Declare=YL=0 $(OPTS) +Ogreen.png   $<
	povray Declare=BL=0 Declare=GL=0 Declare=RL=1 Declare=YL=0 $(OPTS) +Ored.png     $<
	povray Declare=BL=0 Declare=GL=0 Declare=RL=0 Declare=YL=1 $(OPTS) +Oyellow.png $<

.PHONY: clean
clean:; rm -f $(NAME).png
