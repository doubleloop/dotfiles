# there is no python-neovim package yet in repo (still in sid)
# thus local installation is required

if [ -f $WORKON_HOME/nvim/bin/python3 ]; then
    export PYTHON3_NVIM_VIRTUALENV=$WORKON_HOME/nvim/bin/python3
elif [ -f $WORKON_HOME/nvim/bin/python ]; then
    export PYTHON2_NVIM_VIRTUALENV=$WORKON_HOME/nvim/bin/python
else
    echo "Could not find python-neovim installation"
fi