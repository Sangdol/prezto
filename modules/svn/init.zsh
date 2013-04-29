alias s="svn"
alias sa='svn st | grep "^?" | awk '\''{print $2}'\'' | xargs svn add' # Add new files
alias st='s st'
alias sd='s diff'

# Remove the prezto default `sl` alias for `ls`
unalias sl
sl() {
	svn log -vl ${1:-5}
}
