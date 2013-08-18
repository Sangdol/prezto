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

#
# Override
#

# Git
alias gs='git status'	# Override default
alias gst='git stash'	# Set other alias
alias gd='gwd'		# Override default
alias gda='git ls-files'	# Set other alias
alias ga='gia'

# utils
alias mv='mv -vi'
alias cp='cp -vi'
alias rm='rm -vi'

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

open_lastest_screen_shot() {
	if [[ "$OSTYPE" == linux-gnu ]]; then
		o "$HOME/Pictures/$(ls -tr $HOME/Pictures | tail -1)"
	fi
}

watch-vi() {
  # When edit a file with vi, it makes 'created' and 'deleted' event and
  # when touch a file, it makes 'modified' event.
  # This function capture only 'created' and 'modified' event to run command only once.
  watchmedo shell-command \
  --patterns="$1" \
  --command="if [ \"\${watch_event_type}\" == \"created\" -o \
                  \"\${watch_event_type}\" == \"modified\" ]; \
              then $2; \
            fi" \
  .
}

#
# etc
#

# CDPATH
export CDPATH=".:~:~/Projects"

# HISTORY
export HISTCONTROL=ignorespace
