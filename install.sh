#!/bin/bash

PYTHON3_NVIM_VIRTUALENV=$HOME/.virtualenvs/nvim/bin/python3
echo $PYTHON3_NVIM_VIRTUALENV


[ ! -d mackupenv ] && virtualenv mackupenv
. mackupenv/bin/activate
pip install https://github.com/doubleloop/mackup/archive/master.zip

[ ! -f ~/.mackup.cfg ] && cp mackup.cfg.default ~/.mackup.cfg
mackup -f restore

[ ! -d ~/.oh-my-zsh ] && \
    git clone https://github.com/robbyrussell/oh-my-zsh ~/.oh-my-zsh

[ ! -d ~/.fzf ] && \
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --key-bindings --completion --no-update-rc


if [ ! -f ~/.local/share/nvim/site/autoload/plug.vim ]; then
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

WORKON_HOME=$HOME/.virtualenvs
[ ! -d $WORKON_HOME ] && mkdir -p $WORKON_HOME
[ ! -d $WORKON_HOME/nvim ] && \
    virtualenv --python=/usr/bin/python3 $WORKON_HOME/nvim

. $WORKON_HOME/nvim/bin/activate
pip install neovim
export PYTHON3_NVIM_VIRTUALENV=$WORKON_HOME/nvim/bin/python3
vim +PlugInstall +qa

