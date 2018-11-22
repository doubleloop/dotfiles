# there is no python-neovim package yet in repo (still in sid)
# thus local installation is required
if [ -f $WORKON_HOME/nvim3/bin/python3 ]; then
    export PYTHON3_NVIM_VIRTUALENV=$WORKON_HOME/nvim3/bin/python3
fi

if [ -f $WORKON_HOME/nvim/bin/python ]; then
    export PYTHON2_NVIM_VIRTUALENV=$WORKON_HOME/nvim/bin/python
fi

_exists() { (( $+commands[$1] )) }

if [ -n "$NVIM_TERMINAL" ]; then
    alias vim='nvr -s'
    alias vimrc='nvr -s ~/.config/nvim/init.vim'
    export EDITOR='nvr -s'
elif _exists nvim; then
    alias vim=nvim
    alias vimrc='nvim ~/.config/nvim/init.vim'
    export EDITOR=nvim
fi
