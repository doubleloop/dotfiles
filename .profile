# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

export JAVA_HOME=$HOME/opt/jdk1.8.0_131
export GOPATH=$HOME/opt/go
# synclient TapButton1=1 TapButton2=3 TapButton3=2

# make CapsLock behave like Ctrl:
# moved to gnome tweek tools settings
# setxkbmap -option ctrl:nocaps

# make short-pressed Ctrl behave like Escape:
xcape -e 'Control_L=Escape'
xcape -e 'Caps_Lock=Escape'

[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap

