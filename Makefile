FILES := noc1.png noc2.png noc3.png

.PHONY: all
all: $(addprefix media/,$(FILES))

media/noc1.png: nature-of-code/01.vectors/03.random-acceleration.random.ps
	convert -background 'rgb(250,250,250)' -density 400 $< -gravity center -flatten -crop 1:1 $@

media/noc2.png: nature-of-code/01.vectors/03.random-acceleration.attractor.ps
	convert -background 'rgb(250,250,250)' -density 400 $< -gravity center -flatten -crop 1:1  $@

media/noc3.png: nature-of-code/02.force/01.ballon.py
	python3 $< $@
