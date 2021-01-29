bindkey -v
KEYTIMEOUT=10

_insertmode_cursor() { printf "\x1b[5 q\x1b]112\x07" }
_normalmode_cursor() { printf "\x1b[2 q\x1b]112\x07" }

setcursorshape() {
    if [ -z $DISABLE_PROMPT_SWITCH ]; then
        if [ "$KEYMAP" = "vicmd" ]; then
            _normalmode_cursor
        else
            _insertmode_cursor
        fi
    fi
}

# just in case
fix-prompt() {
    DISABLE_PROMPT_SWITCH=1
    _normalmode_cursor
}

zle-keymap-select() {
    # zle reset-prompt
    # zle -R
    setcursorshape
}
zle -N zle-keymap-select

function zle-line-init() {
    setcursorshape
}
zle -N zle-line-init

function zle-line-finish() {
    _normalmode_cursor
}
zle -N zle-line-finish

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

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line
bindkey -M vicmd '^x^e' edit-command-line
bindkey -M vicmd 'vv' edit-command-line

function wrap_clipboard_widgets() {
  # NB: Assume we are the first wrapper and that we only wrap native widgets
  # See zsh-autosuggestions.zsh for a more generic and more robust wrapper
  local verb="$1"
  shift

  local widget
  local wrapped_name
  for widget in "$@"; do
    wrapped_name="_zsh-vi-${verb}-${widget}"
    if [ "${verb}" = copy ]; then
      eval "
        function ${wrapped_name}() {
          zle .${widget}
          printf %s \"\${CUTBUFFER}\" | clipcopy 2>/dev/null || true
        }
      "
    else
      eval "
        function ${wrapped_name}() {
          CUTBUFFER=\"\$(clippaste 2>/dev/null || echo \$CUTBUFFER)\"
          zle .${widget}
        }
      "
    fi
    zle -N "${widget}" "${wrapped_name}"
  done
}

wrap_clipboard_widgets copy vi-yank vi-yank-eol  vi-delete kill-buffer
wrap_clipboard_widgets paste vi-put-{before,after} yank
unfunction wrap_clipboard_widgets
