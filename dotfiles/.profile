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

[ -d $HOME/opt/jdk1.8.0_144 ] && export JAVA_HOME=$HOME/opt/jdk1.8.0_144
[ -d $HOME/.npm-packages ] && export NPM_PACKAGES=$HOME/.npm-packages

# make CapsLock behave like Ctrl:
# moved to gnome tweek tools settings
# setxkbmap -option ctrl:nocaps

# make short-pressed Ctrl behave like Escape:
# type xcape >/dev/null && {
#     xcape -e 'Control_L=Escape'
#     xcape -e 'Caps_Lock=Escape'
# }

# [ -f $HOME/.Xmodmap ] && type xmodmap >/dev/null && xmodmap $HOME/.Xmodmap

