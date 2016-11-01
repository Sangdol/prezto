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

# brew Install wget with IRI support
brew install wget --with-iri

# brew Install more recent versions of some OS X tools
brew install vim --override-system-vi
brew install homebrew/dupes/grep
brew install homebrew/php/php55 --with-gmp

# brew Install other useful binaries
brew install ack
brew install git
brew install node
brew install rename
brew install tree
brew install tig
brew install emacs
brew install trash
brew install fasd
brew install httpie
brew install mycli
brew install lynx
brew install pstree
brew install watch
brew install gcal
brew install thefuck
brew install pandoc

# http://apple.stackexchange.com/questions/69223/how-to-replace-mac-os-x-utilities-with-gnu-core-utilities
brew install grep --with-default-names
brew install gnu-sed --with-default-names

# Java Specific
brew install tomcat
brew install redis
brew install gradle
brew install maven

# For projects
brew install mysql
brew install nginx

# brew Remove outdated versions from the cellar
brew cleanup
