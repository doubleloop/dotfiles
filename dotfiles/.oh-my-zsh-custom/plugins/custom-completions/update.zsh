(( $+commands[rustup] )) && {
    rustup completions zsh cargo >_cargo
    rustup completions zsh rustup >_rustup
}
(( $+commands[gh] )) && gh completion -s zsh > _gh
