#!/bin/bash
active_app=$(osascript <<EOD
tell application "System Events"
	set activeApp to name of first application process whose frontmost is true
	return activeApp
end tell
EOD
)

LOGITECH_ID=fc-58-fa-79-f6-88
ACT_ON=04-fe-a1-6a-96-fe
CURRENT_DEVICE=$ACT_ON

echo "Current app: $active_app"

if [[ "$active_app" != "Melodics" ]];then
  if [[ $(blueutil --is-connected $CURRENT_DEVICE) -eq 1 ]];then
    echo "Already connected."
  else
    blueutil -p 1
    sleep 2  # wait until it turns on bluetooth
    blueutil --connect $CURRENT_DEVICE && echo "Connected!"
  fi
else
  blueutil -p 0 && echo "Disconnected!"
fi
