#!/usr/bin/env bash

# https://stackoverflow.com/questions/24129903/notifying-when-using-high-cpu-via-applescript-or-automator
SAMPLE_SECONDS=30
CPU_THRESHOLD=80

read -r pct name < <(/usr/bin/top -l $SAMPLE_SECONDS -n 1 -F -o cpu -stats cpu,command | tail -1)
if (( ${pct%.*} >= CPU_THRESHOLD )); then
  msg="Process > 80%: $name ($pct%)"
  terminal-notifier -message "$msg" -timeout 5
  echo "$(date +"%Y-%m-%d %H:%M") $msg" >> "$HOME/logs/cpu-monitor.log"
fi
