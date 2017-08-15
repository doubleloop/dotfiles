# there is no python-neovim package yet in repo (still in sid)
# thus local installation is required
if [ -f $WORKON_HOME/nvim/bin/python3 ]; then
    export PYTHON3_NVIM_VIRTUALENV=$WORKON_HOME/nvim/bin/python3
elif [ -f $WORKON_HOME/nvim/bin/python ]; then
    export PYTHON2_NVIM_VIRTUALENV=$WORKON_HOME/nvim/bin/python
fi

if type nvim &>/dev/null; then
    alias vim=nvim
    alias vimrc='nvim ~/.config/nvim/init.vim'
    export EDITOR=nvim
fi
