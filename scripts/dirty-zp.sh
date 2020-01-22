#!/bin/bash

# https://stackoverflow.com/questions/2657935/checking-for-a-dirty-index-or-untracked-files-with-git
function evil_git_num_untracked_files {
  expr `git status --porcelain 2>/dev/null | wc -l`
}

function git_num_master_diff {
    expr `git log origin/master..HEAD | wc -l`
}

if evil_git_num_untracked_files || git_num_master_diff; then
  terminal-notifier -message "zp is dirty." -title zong
fi
