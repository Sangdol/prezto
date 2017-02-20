#!/bin/sh
#
# This script is dependant on m-cli (https://github.com/rgcr/m-cli).
#

HOURS=$(date +"%H")
WALLPAPER_PATH=$HOME/Documents/pictures/wallpapers
SCRIPT_PATH=$HOME/.zprezto/scripts

if [[ $HOURS -ge 18 || $HOURS -le 6 ]];then
  $HOME/.zprezto/scripts/wallpaper $WALLPAPER_PATH/night.jpg
else
  $HOME/.zprezto/scripts/wallpaper $WALLPAPER_PATH/morning.jpg
fi
