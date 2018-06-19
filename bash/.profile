#!/bin/bash

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export PATH="/usr/local/sbin:$PATH"
export PATH="$PATH:`yarn global bin`"
export EDITOR=vim

. ~/.dotfiles/bash/.aliases
. ~/.dotfiles/bash/.docker
. ~/.dotfiles/bash/.mobile
. ~/.dotfiles/bash/.net_core
. ~/.dotfiles/bash/.nvm
. ~/.dotfiles/bash/.python
. ~/.dotfiles/bash/.rvm

source ~/.dotfiles/bash/.bash_powerline.sh

# brew
if [ -f $(brew --prefix)/etc/bash_completion ]; then
. $(brew --prefix)/etc/bash_completion
fi

# gulp
eval "$(gulp --completion=bash)"

echo 'OSX profile loaded.'
