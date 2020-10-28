# there is no python-neovim package yet in repo (still in sid)
# thus local installation is required
if [ -f $WORKON_HOME/nvim/bin/python3 ]; then
    export PYTHON_NVIM_VIRTUALENV=$WORKON_HOME/nvim/bin/python3
fi

if [ -n "$NVIM_TERMINAL" ]; then
    alias vim='nvr -s'
    alias vimrc='nvr -s ~/.config/nvim/init.vim'
    export EDITOR='nvr -s'
elif _exists nvim; then
    alias vim=nvim
    alias vimrc='vim ~/.config/nvim/init.vim'
    export EDITOR=nvim
fi
