#!/bin/bash

function _exists {
    type "$1" &>/dev/null
}

[ -z $WORKON_HOME ] && WORKON_HOME=$HOME/.virtualenvs
[ ! -d $WORKON_HOME ] && mkdir -p $WORKON_HOME

if [ ! -d ~/.oh-my-zsh ]; then
    echo "use install first"
    exit 1
fi

. mackupenv/bin/activate
mackup -f uninstall || exit 1

git pull && \
    git submodule update --init --recursive && \
    git submodule foreach --recursive git reset --hard

sh ~/.oh-my-zsh/tools/upgrade.sh

mackup -f restore

# mackup changes some file permitions
git submodule foreach --recursive git reset --hard

_exists nvim && vim +PlugUpgrade +PlugUpdate +qa

if [ -d ~/.fzf ]; then
    pushd ~/.fzf
    git pull
    ~/.fzf/install --key-bindings --completion --no-update-rc
    popd
fi

[ -f ~/.tmux/plugins/tpm/bin/update_plugins ] && \
    ~/.tmux/plugins/tpm/bin/update_plugins all

