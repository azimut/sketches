#OPENSCAD ?= /usr/bin/openscad
OPENSCAD      ?= OpenSCAD-2026.08.30-x86_64.AppImage
OPENSCAD_ARGS := --hardwarnings --render --autocenter --viewall
OPENSCAD_ARGS += --colorscheme="Nature"
WIDTH         ?= 720
HEIGHT        ?= 720

.PHONY: all
all: stl pov

.PHONY: stl
stl: spinner.stl lholder.stl rholder.stl

.PHONY: pov
pov: spinner.pov lholder.pov rholder.pov

.PHONY: clean
clean: rm -f *.pov *.stl *.png *.mp4

spinner.stl: spoolholder.scad
	$(OPENSCAD) $(OPENSCAD_ARGS) -D show_lholder=false -D show_rholder=false -o $@ $<
spinner.pov: spoolholder.scad
	$(OPENSCAD) $(OPENSCAD_ARGS) -D show_lholder=false -D show_rholder=false -o $@ $<

lholder.stl: spoolholder.scad
	$(OPENSCAD) $(OPENSCAD_ARGS) -D show_rholder=false -D show_spinner=false -o $@ $<
lholder.pov: spoolholder.scad
	$(OPENSCAD) $(OPENSCAD_ARGS) -D show_rholder=false -D show_spinner=false -o $@ $<

rholder.stl: spoolholder.scad
	$(OPENSCAD) $(OPENSCAD_ARGS) -D show_lholder=false -D show_spinner=false -o $@ $<
rholder.pov: spoolholder.scad
	$(OPENSCAD) $(OPENSCAD_ARGS) -D show_lholder=false -D show_spinner=false -o $@ $<

%.png: %.pov; povray +Q11 +O$@ +I$< +W$(WIDTH) +H$(HEIGHT) +A0.3
%.mp4: %.pov
	povray +Q11 +W$(WIDTH) +H$(HEIGHT) +A0.3 -I$< +KI0 +KF360 +KC +KFI0 +KFF100
	ffmpeg -y -i $(<F)%03d.png $@
