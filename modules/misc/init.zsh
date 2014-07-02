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
alias zp="cd ~/.zprezto"

#
# Fasd (https://github.com/clvv/fasd)
#
alias a='fasd -a'        # any
alias s='fasd -si'       # show / search / select
alias d='fasd -d'        # directory
alias f='fasd -f'        # file
alias sd='fasd -sid'     # interactive directory selection
alias sf='fasd -sif'     # interactive file selection
alias z='fasd_cd -d'     # cd, same functionality as j in autojump
alias zz='fasd_cd -d -i' # cd with interactive selection
alias v='f -e vim' # quick opening files with vim

#
# Shortcuts
#
alias h="history"
alias vi='vim'
alias oo='o .'
alias datep="TZ=America/Los_Angeles date" # PST

# Mobile dev(Ubuntu)
export PATH=$PATH:/opt/adt/sdk/platform-tools
alias adb-start="adb forward tcp:9222 localabstract:chrome_devtools_remote"
alias adb-kill="adb kill-server"
alias ap-start="sudo hostapd /etc/hostapd/hostapd.conf"

#
# Override
#

# Git
alias gs='git status' # Override default
alias gst='git stash' # Set other alias
alias gd='gwd'    # Override default
alias gda='git ls-files'  # Set other alias
alias ga='gia'

# utils
alias mv='mv -vi'
alias cp='cp -vi'
alias rm='rm -vi'
alias trash='trash -v'

#
# History
#
unsetopt HIST_VERIFY

#
# functions
#

ggo () {
  git branch | grep "$1" | xargs git checkout
}

md () {
  mkdir -p "$@" && cd "$@"
}

# Python server
serve() {
    local rand=$((RANDOM+10000))
    local port=${1:-$rand}
    python -m SimpleHTTPServer $port > /dev/null 2>&1 &
    o http://localhost:$port
}

copy() {
  # copy without BOM
  cat "$1" | awk '{if(NR==1)sub(/^\xef\xbb\xbf/, "");print}' | pbcopy
}

open_lastest_screen_shot() {
  if [[ "$OSTYPE" == linux-gnu ]]; then
    o "$HOME/Pictures/$(ls -tr $HOME/Pictures | tail -1)"
  fi
}

tellme() {
  if [[ "$OSTYPE" == linux-gnu ]]; then
    echo "notify-send '$1'"
  elif [[ "$OSTYPE" == darwin* ]]; then
    echo "terminal-notifier -message '$1'"
  fi
}

how_old() {
  last_modified=$(stat --format="%Y" "$1")
  current_time=$(date +'%s')
  echo $((current_time - last_modified))
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

kill-tomcat() {
  ps -ef | grep tomcat | grep Bootstrap | awk '{print $2}' | xargs kill -9
}

pp() {
  print -l **/*"$1"*
}

ppp() {
  dirname "$(pp "$1" | head -1)"
}

goppp() {
  cd "$(ppp "$1")"
}

opp() {
  open "$(pp "$1" | head -1)"
}

oppp() {
  open "$(ppp "$1")"
}

cppp() {
  cp "$(pp "$1")" "$2"
}

#
# etc
#

# CDPATH
export CDPATH=.:~:~/Projects

# Just ubuntu
if [[ "$OSTYPE" == linux-gnu ]]; then
  alias trash='trash-put'
fi

# HISTORY
export HISTCONTROL=ignorespace
