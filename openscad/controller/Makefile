#OPENSCAD      ?= /usr/bin/openscad
OPENSCAD      ?= OpenSCAD-2026.08.30-x86_64.AppImage
OPENSCAD_ARGS := --hardwarnings --render --autocenter --viewall
OPENSCAD_ARGS += --colorscheme="Nature"
WIDTH         ?= 720
HEIGHT        ?= 720

.PHONY: all stl pov clean
all: stl pov
stl: frontside.stl backside.stl
pov: frontside.pov backside.pov
clean:; rm -vf *.pov *.stl *.png *.mp4 *.pov-state

define common-patch-pov-steps
        echo '#include "colors.inc"\nbackground {Gray}'    >> $@
	sed -i    '0,/light_source/b;/light_source/d'         $@
	sed -i -E 's/(Rad_Settings\()Radiosity_Normal,/\17,/' $@
	sed -i -E 's/angle [0-9]+.[0-9]+/angle 92.5/'         $@
	sed -i    's/^camera.*/camera { ultra_wide_angle look_at <0, 10, 0>/' $@
	sed -i    's/location.*/location <10, -10, -70>/'       $@
endef

frontside.stl: controller.scad
	$(OPENSCAD) $(OPENSCAD_ARGS) -D show_backside=false -D show_frontside=true -D show_pieces=false -o $@ $<
frontside.pov: controller.scad
	$(OPENSCAD) $(OPENSCAD_ARGS) -D show_backside=false -D show_frontside=true -D show_pieces=false -o $@ $<
	$(common-patch-pov-steps)

backside.stl: controller.scad
	$(OPENSCAD) $(OPENSCAD_ARGS) -D show_backside=true -D show_frontside=false -D show_pieces=false -o $@ $<
backside.pov: controller.scad
	$(OPENSCAD) $(OPENSCAD_ARGS) -D show_backside=true -D show_frontside=false -D show_pieces=false -o $@ $<
	$(common-patch-pov-steps)

# NOTE: These ones are for some cool (? visuals
pieces.pov: controller.scad
	$(OPENSCAD) $(OPENSCAD_ARGS) -D show_backside=false -D show_frontside=false -D show_pieces=true -o $@ $<
	$(common-patch-pov-steps)
almost.pov: controller.scad
	$(OPENSCAD) $(OPENSCAD_ARGS) -D show_backside=true -D show_frontside=false -D show_pieces=true -o $@ $<
	$(common-patch-pov-steps)
controller.pov: controller.scad
	$(OPENSCAD) $(OPENSCAD_ARGS) -D show_backside=true -D show_frontside=true -D show_pieces=true -o $@ $<
	$(common-patch-pov-steps)

%.png: %.pov; povray +Q11 +I$< +W$(WIDTH) +H$(HEIGHT) +A0.3
%.mp4: %.pov
	povray +Q11 +W$(WIDTH) +H$(HEIGHT) +A0.3 -I$< +KI0 +KF360 +KC +KFI0 +KFF100
	ffmpeg -y -i $(<F)%03d.png $@
