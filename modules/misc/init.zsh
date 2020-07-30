#
# Easier navigation: .., ..., ...., ....., ~ and -
#
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ~="cd ~" # `cd` is probably faster to type though
alias -- -="cd -"

alias mv='mv -vi'
alias cp='cp -vi'
alias rm='rm -vi'

alias a="grep"
alias vim=nvim
alias pr="cd ~/projects"
alias tm="cd /tmp"
alias zp="cd ~/.zprezto"
alias misc="vi ~/.zprezto/modules/misc/init.zsh"
alias mac="vi ~/.zprezto/modules/misc/mac.zsh"
alias hosts="sudo vi /etc/hosts"
alias wb="cd ~/workbench"
alias path='echo $PATH | tr ":" "\n"'

#
# OS
#
case `uname` in
  Darwin)
    source "${ZDOTDIR:-${HOME}}/.zprezto/modules/misc/mac.zsh"
  ;;
  Linux)
    alias vi=vim
    export TERM=xterm-256color
  ;;
esac

#
# python
#

alias per='pipenv run'
alias ipystartup="vi ~/.ipython/profile_default/startup/00-imports.py"
alias python=python3
alias da=deactivate

#
# Git
#

alias ma='git checkout master && git pull'
alias gs='git status' # Override default
alias gst='git stash' # Set other alias
alias gd='gwd'    # Override default
alias gda='git ls-files'  # Set other alias
alias ga='gia'
alias gph='git push origin HEAD'
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

#
# Etc.
#
unalias cd

# fzf cd https://github.com/junegunn/fzf/wiki/examples#interactive-cd
function cd() {
    if [[ "$#" != 0 ]]; then
        #builtin cd "$@";
        # + "ls -lh"
        builtin cd "$@" && ls -lh
        return
    fi
    while true; do
        local lsd=$(echo ".." && ls -p | grep '/$' | sed 's;/$;;')
        local dir="$(printf '%s\n' "${lsd[@]}" |
            fzf --reverse --preview '
                __cd_nxt="$(echo {})";
                __cd_path="$(echo $(pwd)/${__cd_nxt} | sed "s;//;/;")";
                echo $__cd_path;
                echo;
                ls -p --color=always "${__cd_path}";
        ')"
        [[ ${#dir} != 0 ]] || return 0
        builtin cd "$dir" &> /dev/null
    done
}

# vim man
# https://github.com/vim-utils/vim-man
vm() {
  vim -c "Man $1 $2" -c 'silent only'
}

vv() {
  vim $(fzf)
}

md () {
  mkdir -p "$@" && cd "$@"
}
