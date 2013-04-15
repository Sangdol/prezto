alias s="svn"
alias sa='svn st | grep "^?" | awk '\''{print $2}'\'' | xargs svn add' # Add new files
alias sl="svn log -vl"

