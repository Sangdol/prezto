#
# Easier navigation: .., ..., ...., ....., ~ and -
#
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ~="cd ~" # `cd` is probably faster to type though
alias -- -="cd -"

alias t="cd ~/temp"
alias dl="cd ~/Downloads"
alias z="cd ~/.zprezto"

#
# Shortcuts
#
alias h="history"
alias vi='vim'
alias oo='o .'
alias ackj="ack --ignore-dir=target"	# ack for java

# For frequent uses
alias gs='git status'	# Override default
alias gst='git stash'	# Set other alias
alias gd='gwd'		# Override default
alias gda='git ls-files'	# Set other alias
alias ga='gia'

#
# History
#
unsetopt HIST_VERIFY

#
# functions
#

# Python server
serve() {
		local rand=$((RANDOM+10000))
    local port=${1:-$rand}
		python -m SimpleHTTPServer $port > /dev/null 2>&1 &
		o http://localhost:$port
}

copy() {
	# copy without BOM
	cat $1 | awk '{if(NR==1)sub(/^\xef\xbb\xbf/, "");print}' | pbcopy
}

# CDPATH
export CDPATH=.:~:~/Projects
