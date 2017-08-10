#!/bin/bash

[ ! -d ~/.oh-my-zsh ] && \
    git clone https://github.com/robbyrussell/oh-my-zsh ~/.oh-my-zsh

# neivun stuff
if [ ! -d $WORKON_HOME/nvim/ ]; then
    mkvirtualenv --python=/usr/bin/python3 nvim
    pip install neovim
fi

# install plug if not installed
if [ ! -f ~/.local/share/nvim/site/autoload/plug.vim ]; then
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

source virtualenvwrapper.sh
mkvirtualenv mackup
pushd mackup
python setup.py install
popd

if [ ! -f ~/.mackup.cfg ]; then
    cp mackup.cfg.default ~/.mackup.cfg
fi

mackup -f restore

