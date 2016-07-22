# prompt configuration
local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})" local current_time="[%{$fg_bold[blue]%}%T%{$reset_color%}]"
local user_host='%{$terminfo[bold]$fg[green]%}%n@%m%{$reset_color%}'
local current_dir='%{$terminfo[bold]$fg[yellow]%} %~%{$reset_color%}'
local pythonenv=' %{$terminfo[bold]$fg[blue]%}$(virtualenv_prompt_info)%{$reset_color%}'
local git_branch='$(git_super_status)%{$reset_color%}'

PROMPT="${user_host}${current_dir}${rvm_ruby}${pythonenv}${git_branch}
%B$%b "
RPS1='$(vi_mode_prompt_info)${return_code}'

ZSH_THEME_GIT_PROMPT_PREFIX=" %{$terminfo[bold]$fg[cyan]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$terminfo[bold]$fg[cyan]%})%{$reset_color%} "

echo -ne "\e[5 q"

MODE_INDICATOR="%{$fg_bold[red]%}<%{$fg[red]%}<<%{$reset_color%}"

zle-keymap-select () {
    if [ "$TERM" = "xterm-256color" ]; then
        if [ $KEYMAP = vicmd ]; then
            # the command mode for vi
            echo -ne "\e[2 q"
        else
            # the insert mode for vi
            echo -ne "\e[5 q"
        fi
    fi
    zle reset-prompt
    zle -R
}

# colors of hilight
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main)
ZSH_HIGHLIGHT_STYLES[alias]='fg=cyan,bold'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=cyan,bold'
ZSH_HIGHLIGHT_STYLES[function]='fg=cyan,bold'
ZSH_HIGHLIGHT_STYLES[command]='fg=cyan,bold'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=cyan,bold,underline'
# ZSH_HIGHLIGHT_STYLES[commandseparator]='none'
ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=cyan,bold'

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
        LESS_TERMCAP_so=$(printf '\e[01;33m') \
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

