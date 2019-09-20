# Updates editor information when the keymap changes.
function zle-keymap-select() {
  zle reset-prompt
}
zle -N zle-keymap-select

bindkey -v

function reset-prompt-accept-line() {
   printf "\x1b[2 q\x1b]112\x07"
   zle accept-line
}
zle -N reset-prompt-accept-line
bindkey '^M' reset-prompt-accept-line

# allow ctrl-p, ctrl-n for navigate history (standard behaviour)
bindkey '^P' up-history
bindkey '^N' down-history

# ctrl + arrows
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word
bindkey -M vicmd '^[[1;5D' backward-word
bindkey -M vicmd '^[[1;5C' forward-word
# alt + arrows
bindkey '^[[1;3D' backward-word
bindkey '^[[1;3C' forward-word
bindkey -M vicmd '^[[1;3D' backward-word
bindkey -M vicmd '^[[1;3C' forward-word
# ctrl+del/backspace
bindkey '^H' backward-kill-word
bindkey '^[[3;5~' kill-word
bindkey -M vicmd '^[[3;5~' kill-word

# vi mode is cool but restore some common shortcuts in insert mode
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
bindkey '^w' backward-kill-word
bindkey '^k' kill-buffer
bindkey '^y' yank

bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char

bindkey '^f' forward-char
bindkey '^b' backward-char
bindkey '^[f' forward-word
bindkey '^[b' backward-word
bindkey '^[t' transpose-words

bindkey -M vicmd 'gg' beginning-of-buffer-or-history
bindkey -M vicmd 'G' end-of-buffer-or-history
bindkey '^x^e' edit-command-line
bindkey -M vicmd '^x^e' edit-command-line
