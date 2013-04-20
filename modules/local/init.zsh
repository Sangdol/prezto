# Host toggler
toggler_path="~/Projects/others/toggler"
alias host-toggler="$toggler_path/toggler.sh"
alias hr="host-toggler real"
alias h1="host-toggler w1-set"
alias h2="host-toggler w2-set"
alias hs="host-toggler stage"
alias hq="host-toggler qa"
alias ht="host-toggler dev"
alias hc="host-toggler custom"
alias hu="$toggler_path/update.sh"		# host updater
alias hh="cat $toggler_path/current"

# Custom Scripts
alias deploy='~/scripts/deploy/local/local-deploy.sh'
alias ws='~/scripts/sh/watch-say.sh'	#watch say

# Functions
bridge() {
	local from=$1
	local to=$2

	local tempPath=$(mktemp -d)
	trap "rm -rf $tempPath" EXIT

	scp -r $1 $tempPath
	command scp -r $tempPath/* $2
}

# Etc
alias subl="/usr/bin/Sublime\ Text\ 2/sublime_text"
