.DELETE_ON_ERROR:

SHELL := /bin/bash -o pipefail
MACROS := $(HOME)/projects/thirdparty/circuit_macros
TEMPL  := ../lib/cm_tikz.tpl

%.tex: %.m4
	cat <(head -n -2 $(TEMPL)) \
	    <(m4 -I $(MACROS) $(MACROS)/pdf.m4 $< | dpic -g) \
	    <(tail -1 $(TEMPL)) > $@
%.pdf: %.tex
	pdflatex -interaction=batchmode -halt-on-error $<
%.png: %.pdf
	convert -density 300 -background white -alpha off -alpha off $< $(DESTDIR)$@

.PHONY: clean
clean:; rm -vf ./*.pdf ./*.png ./*.tex ./*.aux ./*.log texput.log
