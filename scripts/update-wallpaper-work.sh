#!/bin/bash
#

HOURS=$(date +"%H")
WALLPAPER_PATH=$HOME/Documents/pictures/wallpapers
SCRIPT_PATH=$HOME/.zprezto/scripts

update() {
  filename=$1
  $HOME/.zprezto/scripts/wallpaper $WALLPAPER_PATH/$filename.jpg
}

if [[ "$HOURS" -le 12 ]];then
  update morning
elif [[ $HOURS -le 16 ]];then
  update afternoon
else
  update evening
fi
