#!/bin/bash

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export PATH="/usr/local/sbin:$PATH"
export PATH="$PATH:`yarn global bin`"
export EDITOR=vim

. ~/.dotfiles/bash/.aliases
. ~/.dotfiles/bash/.docker
. ~/.dotfiles/bash/.mobile
. ~/.dotfiles/bash/.nvm
. ~/.dotfiles/bash/.python
. ~/.dotfiles/bash/.rvm

source ~/.bash_powerline.sh

# net.core
export ASPNETCORE_ENVIRONMENT="Development"

# brew
if [ -f $(brew --prefix)/etc/bash_completion ]; then
. $(brew --prefix)/etc/bash_completion
fi

# gulp
eval "$(gulp --completion=bash)"

# edit this folder
alias dot="cd ~/.dotfiles"

# reload
alias reload_bash="source ~/.bash_profile; echo '~/.bash_profile reloaded.'"

echo 'OSX profile loaded.'