# prompt configuration

precmd() {
    (( ${+functions[setcursorshape]} )) && setcursorshape
    gs=${+functions[git_super_status]+$(git_super_status)}
    vs=${+functions[virtualenv_prompt_info]+$(virtualenv_prompt_info)}
    gs=${gs:+" %F{white}$gs"}
    vs=${vs:+" %F{blue}$vs"}
    print -P "%B%F{green}%n@%m %F{yellow}%~${vs}${gs}%b%f"
}
PS1="%B%(?.%f.%F{red})$%b%f "

# colored man, based on zsh plugin

man() {
    local normal=$'\e[0m'
    local reversed=$'\e[1;7m'
    local bblue=$'\e[01;38;5;75m'
    local upurple=$'\e[04;38;5;200m'
    env \
        LESS_TERMCAP_mb=${bblue} \
        LESS_TERMCAP_md=${bblue} \
        LESS_TERMCAP_me=${normal} \
        LESS_TERMCAP_so=${reversed} \
        LESS_TERMCAP_se=${normal} \
        LESS_TERMCAP_us=${upurple} \
        LESS_TERMCAP_ue=${normal} \
        man "$@"
}
