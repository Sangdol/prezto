#!/bin/bash
#
# Parse markdown and show the matching section.
#
# usa: short for usage - it's made to search usage of commands
#

FILE=~/Documents/til/commandline.md

# h3 search
sed -n -r "/### $1(\w+)? command/,/###/ {
  p
}" ~/Documents/til/commandline.md | head -n -2 | less

# h2 search
gawk 'BEGIN {
  title_match_count = 0
  marker = 0
}

title_match_count == 0 && /^'$1'(\w+)? command/ {
  title_match_count++;
}

title_match_count > 0 {
  result = result"\n"$0;
}

title_match_count > 0 && /(---|===)/ {
  marker++;
}

marker > 1 {
  print result;
  exit 0;
}' $FILE | tail -n +2 | head -n -3 | less
