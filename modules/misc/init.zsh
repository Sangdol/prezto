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
alias z='fasd_cd -d'     # cd, same functionality as j in autojump
alias v='f -e vim' # quick opening files with vim

#
# Shortcuts
#
alias h="history"
alias oo='o .'
alias pdate="TZ=America/Los_Angeles date" # PST
alias c="gcal ."
alias d="date"
alias tailf="tail -f"
alias misc="vi ~/.zprezto/modules/misc/init.zsh"
alias loc="vi ~/.zprezto/modules/local/init.zsh"
alias cl="watch -t -n1 date" # dynamic clock
alias fuck='eval $(thefuck $(fc -ln -1 | tail -n 1)); fc -R'
alias ltl='launchctl'

#
# Override
#

# Git
alias gs='git status' # Override default
alias gst='git stash' # Set other alias
alias gd='gwd'    # Override default
alias gda='git ls-files'  # Set other alias
alias ga='gia'
alias gpu='git pull --rebase'
alias gt='git tag'
alias grh='git reset @'
alias ge='git blame'
alias g-='git checkout -'

gitcmd () {
  echo 'gsh ggo grni gesh ger ges grp'
}

gsh () {
  git show ${1-@}
}

ggo () {
  git branch | grep "$1" | head -1 | xargs git checkout
}

# git rebase non interactive
grni () {
  GIT_SEQUENCE_EDITOR="sed -ie 's/^pick /e /'" git rebase -i "$@"
}

gesh () {
  git blame -L"$2",+1 "$1" | awk '{print $1}'
}

# blamE Rebase
ger () {
  grni "$(gesh "$@")~"
}

# blamE Show
ges () {
  git show $(gesh "$@")
}

# bash version
#ges () {
  #git show $(git blame -L"$2",+1 "$(git ls-files "$1")" | awk '{print $1}')
#}

# pull target branch and rebase
grp () {
  git checkout "$1" && git pull && git checkout - && git rebase "$1"
}

gh () {
  # Extract account name and repo name from "...:{account-name}/{repo-name}.git"
  repo_path=$(git config --get remote.origin.url | perl -n -e '/:(.*)\.git/ && print $1')

  if [ ! -z "$2" ];then
    line="#L$2"
  fi

  URL="https://github.com/$repo_path/tree/SF/$(git ls-files "$1" | head -1)$line"
  echo "open $URL"
  open "$URL"
}

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

# Explaining shell commands in the shell
# https://www.mankier.com/blog/explaining-shell-commands-in-the-shell.html?hn=1
explain () {
  if [ "$#" -eq 0 ]; then
    while read  -p "Command: " cmd; do
      curl -Gs "https://www.mankier.com/api/explain/?cols="$(tput cols) --data-urlencode "q=$cmd"
    done
    echo "Bye!"
  elif [ "$#" -eq 1 ]; then
    curl -Gs "https://www.mankier.com/api/explain/?cols="$(tput cols) --data-urlencode "q=$1"
  else
    echo "Usage"
    echo "explain                  interactive mode."
    echo "explain 'cmd -o | ...'   one quoted command to explain it."
  fi
}

# edit temp
tempfile () {
  TEMP_DIR="$HOME/Documents/temp"
  if [ ! -d "$TEMP_DIR" ];then
    mkdir "$TEMP_DIR"
  fi

  echo "$TEMP_DIR/$(date +"%y%m%d-%H%M").md"
}

# emacs temp
et () {
  if [ $# -eq 0 ]; then
    emacs $(tempfile)
  else
    emacs $*
  fi
}

vi () {
  if [ $# -eq 0 ]; then
    vim $(tempfile)
  else
    vim $*
  fi
}

# pretty(python) json
pjson () {
  python -m json.tool
}

md () {
  mkdir -p "$@" && cd "$@"
}

# ack and
acka () {
  for var in "$@"
  do
    cmd="$cmd""ack ""$var"" | "
  done
  cmd="${cmd:0: -2}"
  eval "$cmd"
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

# Usage: tellme "Good morning" | at 07:00
# Need to load `atrun` agent on OS X - http://stackoverflow.com/questions/17740563/how-to-use-command-at-to-execute-shell-in-macos
tellme() {
  if [[ "$OSTYPE" == linux-gnu ]]; then
    echo "notify-send '$1'"
  elif [[ "$OSTYPE" == darwin* ]]; then
    echo "growlnotify -ms '$1'"
  fi
}

how_old() {
  last_modified=$(stat --format="%Y" "$1")
  current_time=$(date +'%s')
  echo $((current_time - last_modified))
}

# watchmedo https://github.com/gorakhargosh/watchdog
#
# Installation
# 1. Insatll pip
#   * suo easy_install pip
#   * http://stackoverflow.com/questions/17271319/installing-pip-on-mac-os-x
# 2. Install libyaml
#   * brew install libyaml
# 3. Install watchmedo
#   * pip install watchdog
#
# should quote "$1"
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

# print
ppcmd () {
  echo 'pp ppp goppp opp oppp oappp cppp'
}

# print
pp () {
  print -l **/"$1"*
}

# print all match
pa () {
  print -l **/*"$1"*
}

# print parent
ppp () {
  dirname "$(pp "$1" | head -1)"
}

# go parent
goppp () {
  cd "$(ppp "$1")"
}

# open
opp () {
  open "$(pp "$1" | head -1)"
}

# open parent
oppp () {
  open "$(ppp "$1")"
}

# open all in the parent
oappp () {
  open "$(ppp "$1")"/*
}

# copy
cppp () {
  cp "$(pp "$1")" "$2"
}

#
# etc
#

# CDPATH
export CDPATH=.:~:~/Projects

# Just for Ubuntu
if [[ "$OSTYPE" == linux-gnu ]]; then
  alias trash='trash-put'
  alias ack='ack-grep'
fi

# HISTORY
export HISTCONTROL=ignorespace
