#!/usr/local/bin/gawk -f
#
# awk file to test usa.sh
#
# Usage: gawk ~/Documents/til/commandline.md
#

BEGIN {
  title_match_count = 0
  marker = 0
}

title_match_count == 0 && /^awk(\w+)? command/ {
  title_match_count++
}

title_match_count > 0 {
  result = result"\n"$0
}

title_match_count > 0 && /(---|===)/ {
  marker++
}

marker > 1 {
  print result
  exit 0
}
