player.png: player.pov
	povray +W400 +H150 +A0.3 +UA $<

player.sprite.png: player.png
	magick $< -fuzz 15% -trim +repage $@

.PHONY: clean
clean:; rm -vf ./**png

