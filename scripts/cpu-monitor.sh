#!/usr/bin/env bash
#
# Check cpu usage over time and see if the average is higher than threshold.
#

# https://stackoverflow.com/questions/24129903/notifying-when-using-high-cpu-via-applescript-or-automator
SAMPLE_SIZE=15
DELAY_SECS=3
CPU_THRESHOLD=60
TOP_APP_NUM=5

# -l: samples
# -s: deplay-secs
# -n: number of processes
# -F: Do not calculate statistics on shared libraries, also known as frameworks.
# -o: order by (desc)
# -stats: display keys
read -r name pct < <(/usr/bin/top -s $DELAY_SECS -l $SAMPLE_SIZE -n $TOP_APP_NUM -F -o cpu -stats cpu,pid,command | \
  grep -A$TOP_APP_NUM "%CPU" | \
  grep -v CPU | \
  grep -v "^--" | \
  awk '{arr[$2]+=$1;arr2[$2]=$3} END {for (key in arr) printf("%s\t%s\n", arr2[key], arr[key])}' | \
  sort -n -k2 | \
  tail -1)

pct=$(bc -l <<< "scale=1;$pct / $SAMPLE_SIZE")

# debugging
# echo "$name $pct"

if (( ${pct%.*} >= CPU_THRESHOLD )); then
  msg="Process > $CPU_THRESHOLD%: $name ($pct%)"

  # ignore fucking photoanalysisd
  if [[ "$name" != "photoanalysisd" ]]; then
    terminal-notifier -message "$msg" -timeout 5
  fi

  echo "$(date +"%Y-%m-%d %H:%M") $msg" >> "$HOME/logs/cpu-monitor.log"
fi
