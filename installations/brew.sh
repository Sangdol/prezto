#!/usr/bin/env bash
# Reference https://github.com/mathiasbynens/dotfiles/blob/master/brew.sh

# Install command-line tools using Homebrew.

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Make sure we're using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade --all

# Install GNU core utilities (those that come with OS X are outdated)
# Don't forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
# brew Install Bash 4
brew install bash

# brew Install more recent versions of some OS X tools
brew install vim -- --with-override-system-vi
# brew install homebrew/php/php55 --with-gmp

# brew Install other useful binaries
brew install wget
brew install ack
brew install bat
brew install ccat
brew install cheat
brew install emacs
brew install fzf
brew install gawk
brew install gcal
brew install git
brew install googler
brew install httpie
brew install jq
brew install autojump
brew install lynx
brew install m-cli
brew install mediainfo
brew install mycli
brew install node
brew install pandoc
brew install pstree
brew install rename
brew install rsync
brew install sleepwatcher
brew install tig
brew install tldr
brew install translate-shell
brew install trash
brew install tree
brew install watch
brew install zsh zsh-completions
brew install howdoi
brew install pgcli
brew install postgresql
brew install python3
brew install ag
brew install bluetoothconnector
brew install exa
brew install fd
brew install pyenv
brew install pyenv-virtualenv
brew install blueutil
brew install rust

brew tap wallix/awless; brew install awless

#
# --with-default-names
# http://apple.stackexchange.com/questions/69223/how-to-replace-mac-os-x-utilities-with-gnu-core-utilities
#
# --with-default-names is deprecated
# https://github.com/Homebrew/homebrew-core/issues/15786
# https://stackoverflow.com/questions/15538452/grep-repetition-operator-operand-invalid/45534127#45534127
brew install grep
brew install gnu-sed

# Java Specific
# brew install tomcat
# brew install redis
# brew install gradle
brew install maven

# For projects
# brew install mysql
# brew install nginx

# Cask
brew cask install ngrok
# brew Remove outdated versions from the cellar
brew cleanup
