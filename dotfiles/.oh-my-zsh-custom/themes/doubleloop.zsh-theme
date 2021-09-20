# prompt configuration

precmd() {
    (( ${+functions[setcursorshape]} )) && setcursorshape
    gs=${+functions[git_super_status]+$(git_super_status)}
    vs=${+functions[virtualenv_prompt_info]+$(virtualenv_prompt_info)}
    gs=${gs:+" %F{white}$gs"}
    vs=${vs:+" %F{blue}$vs"}
    print -P "%B%F{green}%n@%m %F{yellow}%50<...<%~%<<${vs}${gs}%b%f"
}
PS1="%B%(?.%f.%F{red})$%b%f "
