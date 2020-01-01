#!/bin/sh
active_app=$(osascript <<EOD
tell application "System Events"
	set activeApp to name of first application process whose frontmost is true
	return activeApp
end tell
EOD
)

echo $active_app
if [[ "$active_app" != "Melodics" ]];then
  BluetoothConnector --connect fc-58-fa-79-f6-88 || true
  echo "Connected!"
fi
