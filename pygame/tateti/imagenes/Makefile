SHELL  := /bin/bash
MARGIN := 40
xblue.png:; magick xc:transparent -geometry 300x300                   -stroke blue -strokewidth 30 -draw 'line 60,60,240,240 line 240,60,60,240' $@
ored.png: ; magick xc:transparent -geometry 300x300 -fill transparent -stroke red  -strokewidth 30 -draw 'circle 150,150,60,150' $@
grid.png:
	magick xc:transparent -geometry 900x900 -fill transparent -stroke gray -strokewidth 20 \
	-draw "line 300,$(MARGIN),300,$$(( 900 - $(MARGIN)))" \
	-draw "line 600,$(MARGIN),600,$$(( 900 - $(MARGIN)))" \
	-draw "line $(MARGIN),300,$$(( 900 - $(MARGIN))),300" \
	-draw "line $(MARGIN),600,$$(( 900 - $(MARGIN))),600" $@
