@PHONY: all
all: imgs/noc1.png imgs/noc2.png

imgs/noc1.png: nature-of-code/01.vectors/03.random-acceleration.random.ps
	convert -density 400 $< -gravity center -crop 1:1 -background 'rgb(250,250,250)' -flatten $@

imgs/noc2.png: nature-of-code/01.vectors/03.random-acceleration.attractor.ps
	convert -density 400 $< -gravity center -crop 1:1 -background 'rgb(250,250,250)' -flatten $@
