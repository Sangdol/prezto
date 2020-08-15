#!/usr/bin/env bash

# https://stackoverflow.com/questions/24129903/notifying-when-using-high-cpu-via-applescript-or-automator
# -l 10: sampling for 10 seconds
read -r pct name < <(/usr/bin/top -l 60 -n 1 -F -o cpu -stats cpu,command | tail -1)
if (( ${pct%.*} >= 80 )); then
  terminal-notifier -message "Process > 80%: $name ($pct%)"
fi
