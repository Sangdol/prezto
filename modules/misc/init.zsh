#
# Easier navigation: .., ..., ...., ....., ~ and -
#
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ~="cd ~" # `cd` is probably faster to type though
alias -- -="cd -"

alias please=sudo
alias ag="ag --pager 'less -R'"
alias per='pipenv run'
alias python=python3
alias pip=pip3
alias 3=python3
alias os=osascript
alias pr="cd ~/projects"
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
alias ic="~/Documents/scripts/imgcat.sh" # https://www.iterm2.com/documentation-images.html
alias goo="googler -l en" # https://github.com/jarun/googler
alias no="terminal-notifier -message"
alias tl="tail /usr/local/var/log/alfred-timer.log && date" # timer log
alias hammer="vi ~/.hammerspoon/init.lua"
alias jclip="pbpaste | jq . | pbcopy"
alias path='echo $PATH | tr ":" "\n"'

alias dckrr='docker-machine restart default'
alias dckr='eval "$(docker-machine env default)"'

alias today='gcalcli agenda 10am 7pm'
alias kc=kubectl
alias mk=minikube

#
# Fasd (https://github.com/clvv/fasd)
#
alias z='fasd_cd -d'     # cd, same functionality as j in autojump
alias f='fasd -f'        # file
alias v='f -e vim' # quick opening files with vim

#
# Shortcuts
#
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
alias ipystartup="vi ~/.ipython/profile_default/startup/00-imports.py"

# http://apple.stackexchange.com/questions/3454/say-in-different-language
alias s='say'
alias sg='say -v Anna' # German
alias sb='say -v Daniel' # GB
alias sf='say -v Amelie' # FR
alias si='say -v Alice' # FR
alias icloud='cd ~/Library/Mobile\ Documents' # cd ~ && ln -s ~/Library/Mobile\ Documents iCloud

alias h='function hdi(){ howdoi $* -c; }; hdi'
alias h5='function hdi(){ howdoi $* -c -n 5; }; hdi'

# howdoi --link
hl() {
  open $(h -l "$@")
}

#
# Override
#

# Git
alias ma='git checkout master && git pull'
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
alias gdm='gd origin/master...' # origin/master - no need to keep the local master latest
alias gdms='gd origin/master... --stat'
alias gpp='gp -u origin HEAD'

delete-merged() {
  git branch --merged | egrep -v "(^\*|master|dev)" | xargs git branch -d
}

# zzom - til, tldr, cheat
zz () {
  for command in {til,tldr,cheat};do
    res="$res""-------- $command --------\n"
    res="$res$(eval "${command} $@")\n"
  done

  echo "$res" | less
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
  target=${1:-master}
  git checkout "$target" && git pull && git checkout - && git rebase "$target"
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

# Show PR number of a commit
# source: https://coderwall.com/p/kxb7kg/find-a-pull-request-given-the-commit-sha
# SO (not directly related): http://stackoverflow.com/questions/17818167/find-a-pull-request-on-github-where-a-commit-was-originally-created
gpr () {
  git log --merges --ancestry-path --oneline $1..master | grep 'pull request' | tail -n1 | awk '{ print $5 }';
}

# git branch delete merged
gbdm () {
  git branch --merged | egrep -v master | xargs git branch -d
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

function tran() {
  trans "$@" | less -r
}

# Constant to snake e.g., AB_CD -> ab-cd
# as to ORS http://stackoverflow.com/questions/2021982/awk-without-printing-newline
c-to-s () {
  pbpaste | awk -v ORS="" '{print tolower($0)}' | sed 's/_/-/g' | pbcopy
}

dic() {
  dict "$@" | less
}

unalias cd
cd () {
  builtin cd "$@" && ls -lh
}

# download img from loremflickr
image() {
  filename=$1.jpeg
  width=$2
  height=$3
  if [[ $# -lt 2 ]]
  then
    echo "usage: image filename width [height]"
    return 1
  elif [[ $# -eq 2 ]]
  then
    height=$width
  fi
  wget -O "$filename" "http://loremflickr.com/$width/$height"
}

nd() {
  node $HOME/Projects/ndicer/ndicer.js $@ | less
  # or `npm install -g`
  # node /usr/local/lib/node_modules/ndicer/ndicer.js $@ | less
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

# Examples section
# https://news.ycombinator.com/item?id=10797303
eg(){
    MAN_KEEP_FORMATTING=1 man "$@" 2>/dev/null \
        | sed --quiet --expression='/^E\(\x08.\)X\(\x08.\)\?A\(\x08.\)\?M\(\x08.\)\?P\(\x08.\)\?L\(\x08.\)\?E/{:a;p;n;/^[^ ]/q;ba}' \
        | ${MANPAGER:-${PAGER:-pager -s}}
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
em () {
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

# node http server
serve() {
  local port=${1:-8080}
  http-server -c-1 -p $port &
  o http://localhost:$port
  fg
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

# Chrome Google
cg() {
  open /Applications/Firefox.app/ "http://www.google.com/search?q=$*";
}

# Firefox Google
ffg() {
  open /Applications/Firefox.app/ "http://www.google.com/search?q=$*";
}

# Just for Ubuntu
if [[ "$OSTYPE" == linux-gnu ]]; then
  alias trash='trash-put'
  alias ack='ack-grep'
fi

# HISTORY
export HISTCONTROL=ignorespace

# Schedule sleep in X minutes, use like: sleep-in 60
function sleep-in() {
  local minutes=$1
  local datetime=`/bin/date -v+${minutes}M +"%m/%d/%y %H:%M:%S"` # BSD date
  sudo pmset schedule sleep "$datetime"
}

compress_mts() {
  for f in **/*MTS;do
    no_ext="${f%.*}"
    target="$no_ext".mp4

    if [[ ! -f "$target" ]];then
      echo "------ Compressing $target -------" | tee -a compress_mts.log
      ffmpeg -i "$f" -c:v libx264 -crf 20 -c:a aac "$target" 2>&1 | tee -a compress_mts.log
      echo "------ $target compressed. Mac is taking a 30 seconds rest. -------" | tee -a compress_mts.log
      sleep 30
    else
      echo "------ $target already exist -------" | tee -a compress_mts.log
    fi
  done

  if [[ "$1" == "sleep" ]];then
    m sleep
  fi
}

#
# aws
#
alias a3='aws s3'

als() {
  # Remove 's3://' if exist
  b=$(echo $1 | sed -r 's/^s3:\/\///')
  echo "aws s3 ls s3://$b"
  aws s3 ls s3://$b
}

acp() {
  echo "aws s3 cp $1 $2"
  aws s3 cp $1 $2
}

bucket-policy() {
  aws s3api get-bucket-policy --bucket "$1" --output text | jq .
}

# vim man
# https://github.com/vim-utils/vim-man
vm() {
  vim -c "Man $1 $2" -c 'silent only'
}

vv() {
  vim $(fzf)
}

s10() {
  for i in {1..10};do
    say $@
    sleep 1
  done
}

argtest() {
  echo '$#' $#
  echo '$*' $*
  echo '$@' $@
  echo '$0' $0
  echo '$1' $1
  echo '$2' $2
}

# https://superuser.com/questions/611538/is-there-a-way-to-display-a-countdown-or-stopwatch-timer-in-a-terminal
countdown(){
    date1=$((`date +%s` + $1));
    while [ "$date1" -ge `date +%s` ]; do
    ## Is this more than 24h away?
    days=$(($(($(( $date1 - $(date +%s))) * 1 ))/86400))
    echo -ne "$days day(s) and $(date -u --date @$(($date1 - `date +%s`)) +%H:%M:%S)\r";
    sleep 0.1
    done
}

# https://superuser.com/questions/611538/is-there-a-way-to-display-a-countdown-or-stopwatch-timer-in-a-terminal
stopwatch(){
    date1=`date +%s`;
    while true; do
    days=$(( $(($(date +%s) - date1)) / 86400 ))
    echo -ne "$days day(s) and $(date -u --date @$((`date +%s` - $date1)) +%H:%M:%S)\r";
    sleep 0.1
    done
}
