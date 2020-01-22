# doubleloop prompt configuration
precmd() {
    print -P "%B%F{green}%n@%m %F{yellow}%~"\
             "%F{blue}$(virtualenv_prompt_info 2>/dev/null)"\
             "%F{white}$(git_super_status 2>/dev/null)%E"
    _setcursorshape 2> /dev/null
}
PS1="%B%(?..%F{red})$%b%f "

# colored man, based on zsh plugin
# http://www.tuxarena.com/2012/04/tutorial-colored-man-pages-how-it-works/

# LESS_TERMCAP_mb: enter blinking mode
# LESS_TERMCAP_md: enter double-bright mode
# LESS_TERMCAP_me: turn off all appearance modes (mb, md, so, us)
# LESS_TERMCAP_se: leave standout mode
# LESS_TERMCAP_so: enter standout mode
# LESS_TERMCAP_ue: leave underline mode
# LESS_TERMCAP_us: enter underline mode

man() {
   env \
      LESS_TERMCAP_mb=$(printf '\e[01;31m') \
      LESS_TERMCAP_md=$(printf '\e[01;38;5;75m') \
      LESS_TERMCAP_me=$(printf '\e[0m') \
      LESS_TERMCAP_se=$(printf '\e[0m') \
      LESS_TERMCAP_so=$(printf '\e[1;27;7m') \
      LESS_TERMCAP_ue=$(printf '\e[0m') \
      LESS_TERMCAP_us=$(printf '\e[04;38;5;200m') \
      _NROFF_U=1 \
         man "$@"
}

#########################################
# Colorcodes:
# Black       0;30     Dark Gray     1;30
# Red         0;31     Light Red     1;31
# Green       0;32     Light Green   1;32
# Brown       0;33     Yellow        1;33
# Blue        0;34     Light Blue    1;34
# Purple      0;35     Light Purple  1;35
# Cyan        0;36     Light Cyan    1;36
# Light Gray  0;37     White         1;37
#########################################
