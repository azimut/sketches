player.png: player.pov
	povray +W400 +H150 +A0.3 +UA $<

# Tricky due I have a transparency gruge on my rock
# 1) auto-trim borders
# 2) replace all transparency with black
# 3) fill back black on borders with floodfills on 4 corners
player.sprite.png: player.png
	magick $< -fuzz 15% -trim +repage \
		-background black -alpha remove \
		-fill none -fuzz 3% \
		-floodfill '+0+0'                 black \
		-floodfill '+0+%[fx:h-1]'         black \
		-floodfill '+%[fx:w-1]+0'         black \
		-floodfill '+%[fx:w-1]+%[fx:h-1]' black $@
