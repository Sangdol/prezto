#!/bin/bash
#

HOURS=$(date +"%H")
WALLPAPER_PATH=$HOME/Documents/pictures/wallpapers
SCRIPT_PATH=$HOME/.zprezto/scripts

update() {
  filename=$1
  m wallpaper $WALLPAPER_PATH/$filename.jpg
}

# Bash error: value too great for base (error token is “09”)
# http://stackoverflow.com/questions/21049822/bash-error-value-too-great-for-base-error-token-is-09
if [[ "10#$HOURS" -le 12 ]];then
  update morning
elif [[ "$HOURS" -le 17 ]];then
  update afternoon
elif [[ "$HOURS" -le 20 ]];then
  update evening
else
  update night
fi
