#!/usr/bin/env bash

echo $(date) >> /usr/local/var/log/auto-git-fetch.log

DIR_PREFIX="$HOME/projects"

for project in $DIR_PREFIX/*/;
do
  if [[ -d "$project.git" ]];then
    cd "$project" && git fetch
  fi
done
