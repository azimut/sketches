.PHONY: all empezar misil boom
all: boom empezar misil
boom:  boom.ogg  boom.png  boom_wave.png
empezar: empezar.ogg empezar_wave.png empezar.png
misil: misil.ogg misil.png misil_wave.png

%.png: %.ogg
	sox $< -n spectrogram -t $< -o $@

%_wave.png: %.ogg
	sox $< -t dat - | grep -v ';' | gnuplot -e 'set monochrome; set title "$<" ; set autoscale fix; unset border; set grid; set tics scale 0; unset key; set term pngcairo ; set output "$@" ; plot "-" with lines'

misil.ogg:
	sox -b 16 -n $@ \
	synth \
	pluck %-0 \
	pluck %-2 \
	pluck %-4 \
	pluck %-5 \
	pluck %-7 \
	fade q .2 1.1 .5 \
	delay 0 1 2 3 4 \
	remix - \
	lowpass -2 6k 10k \
	stretch .01 \
	vol 1

boom.ogg: OFFSET = 36
boom.ogg: RKEYS  = 0 2 3 5 7 12 5 3 2 3 7 12 0 2 3 5 7 12
boom.ogg:  KEYS  = $(foreach key,$(RKEYS),$(shell dc -e '$(key) $(OFFSET) - p'))
boom.ogg: DT     = 0.2
boom.ogg:
	sox -b 16 -n $@ \
	synth \
	$(foreach key,$(KEYS), pluck %$(key)) \
	fade h .2 0.5 .1 \
	delay 0 $(foreach _,$(shell seq $$(( $(words $(KEYS))  - 1 ))),+$(DT)) \
	remix - \
	pitch -100 \
	stretch .07 \
	chorus .9 .3 100 0.3 0.4 2.3 -t

empezar.ogg: OFFSET = 12
empezar.ogg: RKEYS  = 0 2 3 5 7 12
empezar.ogg:  KEYS  = $(foreach key,$(RKEYS),$(shell dc -e '$(key) $(OFFSET) + p'))
empezar.ogg: DT     = 0.2
empezar.ogg:
	sox -b 16 -n $@ \
	synth \
	$(foreach key,$(KEYS), pluck %$(key)) \
	fade h .2 0.9 .1 \
	delay 0 $(foreach _,$(shell seq $$(( $(words $(KEYS))  - 1 ))),+$(DT)) \
	remix - \
	pitch -100 \
	stretch .1 \
	chorus .1 .4 100 0.3 0.1 2.0 -t
