#
# Easier navigation: .., ..., ...., ....., ~ and -
#
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ~="cd ~" # `cd` is probably faster to type though
alias -- -="cd -"

alias a="grep"
alias te="cd ~/temp"
alias tm="cd /tmp"
alias wb="cd ~/workbench"
alias dl="cd ~/Downloads"
alias zp="cd ~/.zprezto"
alias jt="cd ~/Projects/java-test-driven-learning/src/test/java"
alias nconf="cd /usr/local/etc/nginx/conf"
alias ackrc="vi ~/.ackrc"
alias sconf="vi ~/.ssh/config"
alias we="curl http://wttr.in/berlin"
alias hosts="sudo vi /etc/hosts"
alias bt="cd ~/Projects/bash-test-driven-learning/"
alias ic="~/scripts/imgcat.sh"

alias dckrr='docker-machine restart default'
alias dckr='eval "$(docker-machine env default)"'

#
# Fasd (https://github.com/clvv/fasd)
#
alias z='fasd_cd -d'     # cd, same functionality as j in autojump
alias f='fasd -f'        # file
alias v='f -e vim' # quick opening files with vim

#
# Shortcuts
#
alias h="history"
alias oo='o .'
alias pd="TZ=America/Los_Angeles date" # PST
alias ud="TZ=UTC date" # UTC
alias c="gcal ."
alias d="date"
alias tailf="tail -f"
alias misc="vi ~/.zprezto/modules/misc/init.zsh"
alias loc="vi ~/.zprezto/modules/local/init.zsh"
alias cl="watch -t -n1 date" # dynamic clock
alias fk='eval $(thefuck $(fc -ln -1 | tail -n 1)); fc -R'
alias ltl='launchctl'
alias lines='wc -l'
alias ts='node -e "process.stdout.write((+new Date).toString())" | pbcopy' # node -p "+new Date" | pbcopy' - makes newline
alias s='say'
alias sg='say -v Anna' # German - http://apple.stackexchange.com/questions/3454/say-in-different-language

#
# Override
#

# Git
alias ma='git checkout master'
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
alias gre='gc --amend --reuse-message HEAD'
alias gbd='gb -d'
alias gbD='gb -D'
alias gdm='gd master...'
alias gdms='gd master... --stat'

guser () {
  git config user.name "Sanghyun Lee"
  git config user.email "hammerha@gmail.com"
  git commit --amend --reset-author --no-edit
  git log
}

# Recover deleted file
# http://stackoverflow.com/questions/953481/restore-a-deleted-file-in-a-git-repo
grevive () {
  git checkout $(git rev-list -n 1 HEAD -- "$1")~ -- "$1"
}

# Ignore file
gig () {
  echo "Ignored" "$@"
  git update-index --assume-unchanged "$@"
}

gnig () {
  echo "Un-ignore" "$@"
  git update-index --no-assume-unchanged "$@"
}

# stash commit
gscm () {
  ga . && gc --no-verify -m "Stash commit"
}

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

# For CircleCI
gcis () {
  GIT_EDITOR="sed -ie '1 s/$/ \[ci skip\]/'" git commit --amend
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

# Extract account name and repo name from "...:{account-name}/{repo-name}.git"
repopath () {
  echo $(git config --get remote.origin.url | perl -n -e '/:(.*)\.git/ && print $1')
}

# $ gh <branch> <file> [line]
gh () {
  repo_path=$(repopath)

  if [ ! -z "$3" ];then
    line="#L$3"
  fi

  URL="https://github.com/$repo_path/tree/$1/$(git ls-files "$2" | head -1)$line"
  echo "open $URL"
  open "$URL"
}

# $ gh <file> [line]
ghs () {
  gh SF $1 $2
}

# github compare
# $ ghcmp <sha> <sha>
ghcmp () {
  repo_path=$(repopath)
  URL="https://github.com/$repo_path/compare/$1...$2"
  echo "open $URL"
  open "$URL"
}

# github commit
ghc () {
  open "https://github.com/comicpanda/comic-panda/commit/$1"
}

# utils
alias mv='mv -vi'
alias cp='cp -vi'
alias rm='rm -vi'
alias t='trash -v'

#
# History
#
unsetopt HIST_VERIFY

#
# functions
#

cd() {
  builtin cd "$@" && ls -lh
}

# download img from loremflickr
image() {
  filename=$1.jpeg
  width=$2
  height=$3
  if [[ $# -lt 2 ]]
  then
    echo "usage: lf filename width [height]"
    return 1
  elif [[ $# -eq 2 ]]
  then
    height=$width
  fi
  wget -O "$filename" "http://loremflickr.com/$width/$height"
}

nd() {
  node ~/Projects/ndicer/ndicer.js $@ | less
}

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
  TEMP_DIR="$HOME/workbench/notes"
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
#   * sudo easy_install pip
#   * http://stackoverflow.com/questions/17271319/installing-pip-on-mac-os-x
# 2. Install libyaml
#   * brew install libyaml
# 3. Install watchmedo
#   * pip install watchdog
#
# Usage
# * For some reason, using exact match pattern doesn't work. Use '*' always.
# * If you want to see what events are happening add the variable with parens.
# $ watch-vi "*clj" 'echo "${watch_event_type}"'
# $ watch-vi "*clj" 'lein test'
watch-vi() {
  # When edit a file with vi, it makes 'created' and 'deleted' event and
  # when touch a file, it makes 'modified' event.
  # This function capture only 'created' and 'modified' event to run command only once.
  # ... For some reason when I test again modifying a file makes 'created' and 'modified' events so removed capturing 'created' event.
  # ... sometimes it makes 'created' and 'deleted' event. not sure why.
  watchmedo shell-command \
  --patterns="$1" \
  --command="if [ \"\${watch_event_type}\" == \"created\" ];then \
               echo '------------------------'; \
               $2; \
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

# Smart extract - makes directories when neccessary
# http://unix.stackexchange.com/questions/64047/create-directory-if-zip-archive-contains-several-files
unz() (
  if [ $# -eq 0 ];then
    echo 'Usage: $ unz (unzip|tar) <file>'
    exit
  fi

  tmp=$(TMPDIR=. mktemp -d -- ${${argv[-1]:t:r}%.tar}.XXXXXX) || exit
  print -r >&2 "Extracting in $tmp"
  cd -- $tmp || exit
  [[ $argv[-1] = /* ]] || argv[-1]=../$argv[-1]
  (set -x; "$@"); ret=$?
  files=(*(ND[1,2]))
  case $#files in
    (0) print -r >&2 "No file created"
        rmdir -v "../$tmp";;
    (1) mv -v -- $files .. && rmdir ../$tmp;;
    (*) mv -v ../$tmp ../$tmp:r;;
  esac && exit $ret
)

#
# etc
#

# CDPATH
export CDPATH=.:~:~/Projects:~/Documents

# Just for Ubuntu
if [[ "$OSTYPE" == linux-gnu ]]; then
  alias trash='trash-put'
  alias ack='ack-grep'
fi

# HISTORY
export HISTCONTROL=ignorespace

