@PHONY: all
all: imgs/noc1.png imgs/noc2.png

imgs/noc1.png: nature-of-code/01.vectors/03.random-acceleration.random.ps
	convert -background 'rgb(250,250,250)' -density 400 $< -gravity center -flatten -crop 1:1 $@

imgs/noc2.png: nature-of-code/01.vectors/03.random-acceleration.attractor.ps
	convert -background 'rgb(250,250,250)' -density 400 $< -gravity center -flatten -crop 1:1  $@
