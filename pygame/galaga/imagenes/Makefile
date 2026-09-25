nave.png:
	magick xc:transparent -geometry 100x100 \
	-fill green -stroke black \
	-draw "path 'M50,10 L80,80 L50,60 \
                     M50,10 L20,80 L50,60'" \
	-fuzz 15% -trim +repage \
	-channel RGB -fx 'Xi=i-w/2; Yj=j-h/2+20; 0.8*(0.5-hypot(Xi,Yj)/70.0)+0.5' \
	\( xc:"#cccc00" xc:"#00ffff" xc:"#aaa" +append \) \
	-clut $@

misil.png:
	magick xc:transparent -geometry 100x100 \
	-draw 'scale 0.8,0.8 \
               fill red    circle 50,50,30,50 \
               fill orange circle 50,50,35,50 \
               fill yellow circle 50,50,40,50' \
	-fuzz 15% -trim +repage $@

enemigo.png:
	magick xc:transparent -geometry 100x100 \
	-draw 'fill purple polygon 40,50 50,20 60,50 50,80 \
                           polygon 30,50 35,35 40,50 35,60 \
                           polygon 60,50 65,35 70,50 65,60' \
	-fuzz 15% -trim +repage $@
