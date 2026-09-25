.PHONY: clean
clean: ; rm -vf ./*.png

.PHONY: all
all: lado1.png lado2.png lado3.png lado4.png lado5.png lado6.png

lado1.png:; magick xc:transparent -geometry 300x300 -stroke NavajoWhite -strokewidth 3 -fill PapayaWhip -draw "roundrectangle 30,30,270,270,30,30" -fill black -gravity center -strokewidth 0 -stroke black -draw "circle %[fx:(w-1)/2],%[fx:(h-1)/2],%[fx:((w-1)/2)+20],%[fx:(h-1)/2]" $@

lado2.png:; magick xc:transparent -geometry 300x300 -stroke NavajoWhite -strokewidth 3 -fill PapayaWhip -draw "roundrectangle 30,30,270,270,30,30" -fill black -gravity center -strokewidth 0 -stroke black -draw "circle 90,90,110,90 circle 210,210,230,210" $@

lado3.png:; magick xc:transparent -geometry 300x300 -stroke NavajoWhite -strokewidth 3 -fill PapayaWhip -draw "roundrectangle 30,30,270,270,30,30" -fill black -gravity center -strokewidth 0 -stroke black -draw "circle 90,90,110,90 circle 150,150,170,150 circle 210,210,230,210" $@

lado4.png:; magick xc:transparent -geometry 300x300 -stroke NavajoWhite -strokewidth 3 -fill PapayaWhip -draw "roundrectangle 30,30,270,270,30,30" -fill black -gravity center -strokewidth 0 -stroke black -draw "circle 90,90,110,90 circle 210,90,230,90 circle 90,210,110,210 circle 210,210,230,210" $@

lado5.png:; magick xc:transparent -geometry 300x300 -stroke NavajoWhite -strokewidth 3 -fill PapayaWhip -draw "roundrectangle 30,30,270,270,30,30" -fill black -gravity center -strokewidth 0 -stroke black -draw "circle 90,90,110,90 circle 210,90,230,90 circle 150,150,170,150 circle 90,210,110,210 circle 210,210,230,210" $@

lado6.png:; magick xc:transparent -geometry 300x300 -stroke NavajoWhite -strokewidth 3 -fill PapayaWhip -draw "roundrectangle 30,30,270,270,30,30" -fill black -gravity center -strokewidth 0 -stroke black -draw "circle 90,90,110,90 circle 210,90,230,90 circle 90,150,110,150 circle 210,150,230,150 circle 90,210,110,210 circle 210,210,230,210" $@
