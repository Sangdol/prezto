all: compile

run-preview:
	osascript preview.scpt

run-youtube:
	osascript youtube-music.scpt

compile:
	osacompile -o youtube-music-compiled.scpt youtube-music.scpt
	osacompile -o youtube-music-like-compiled.scpt youtube-music-like.scpt
	osacompile -o preview{-compiled,}.scpt
