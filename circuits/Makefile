.DELETE_ON_ERROR:

SHELL := /bin/bash -o pipefail
MACROS := $(HOME)/projects/thirdparty/circuit_macros

%.pdf: %.m4
	m4 -I $(MACROS) $(MACROS)/pdf.m4 $< | dpic -d > $@
%.png: %.pdf
	convert -density 200 -transparent white $< $(DESTDIR)$@

.PHONY: clean
clean:; rm -vf ./*.pdf ./*.png
