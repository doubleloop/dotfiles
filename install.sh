#!/bin/bash

function _exists {
    type "$1" &>/dev/null
}

[ -z $WORKON_HOME ] && WORKON_HOME=$HOME/.virtualenvs
[ ! -d $WORKON_HOME ] && mkdir -p $WORKON_HOME
PYTHON3_NVIM_VIRTUALENV=$WORKON_HOME/nvim/bin/python3

git submodule update --init --recursive

[ ! -d ~/.oh-my-zsh ] && \
    git clone https://github.com/robbyrussell/oh-my-zsh ~/.oh-my-zsh
[ -z $FULL_INSTALL ] && [ ! -f ~/.zsh_plugins ] && \
    cp zsh_plugins.default ~/.zsh_plugins

[ ! -d mackupenv ] && virtualenv mackupenv
. mackupenv/bin/activate && \
pip install https://github.com/doubleloop/mackup/archive/master.zip

[ ! -f ~/.mackup.cfg ] && cp mackup.cfg.default ~/.mackup.cfg
mackup -f restore

# mackup changes some file permitions
git submodule foreach --recursive git reset --hard

[ ! -d ~/.fzf ] && \
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --key-bindings --completion --no-update-rc

if _exists nvim; then
    if [ ! -f ~/.local/share/nvim/site/autoload/plug.vim ]; then
        curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    fi

    [ ! -d $WORKON_HOME/nvim ] && \
        virtualenv --python=/usr/bin/python3 $WORKON_HOME/nvim

    . $WORKON_HOME/nvim/bin/activate && \
    pip install neovim
    export PYTHON3_NVIM_VIRTUALENV=$WORKON_HOME/nvim/bin/python3
    vim +PlugInstall +qa
fi

if _exists tmux && [ ! -d  ~/.tmux/plugins/tpm ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    ~/.tmux/plugins/tpm/bin/install_plugins
fi
