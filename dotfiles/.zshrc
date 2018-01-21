# https://www.topbug.net/blog/2016/10/11/speed-test-check-the-existence-of-a-command-in-bash-and-zsh/
_exists() { (( $+commands[$1] )) }

### oh-my-zsh settings ###
# https://github.com/robbyrussell/oh-my-zsh/blob/master/templates/zshrc.zsh-template
export ZSH=$HOME/.oh-my-zsh
ZSH_CUSTOM=$HOME/.oh-my-zsh-custom
ZSH_THEME="doubleloop"
HYPHEN_INSENSITIVE="true"
export UPDATE_ZSH_DAYS=13
eISABLE_AUTO_TITLE="true"
ENABLE_CORRECTION="false"
DISABLE_UNTRACKED_FILES_DIRTY="true"
HIST_STAMPS="yyyy-mm-dd"

ZSH_TMUX_AUTOSTART="true"
ZSH_TMUX_AUTOCONNECT="true"

### Plugins ###
# allow custom plugins setup
if [ -f ~/.zsh_plugins ]; then
    . ~/.zsh_plugins
else
    # Add wisely, as too many plugins slow down shell startup
    plugins=(
        alias-tips
        common-aliases fasd colorize extract command-not-found
        vagrant
        docker
        valut
        tmux
        vi-mode
        golang
        jsontools
        supervisor
        gitfast gitignore zsh-git-prompt
        debian
        pip python virtualenv virtualenvwrapper
        django
        atom sublime
        cabal stack
        jira
        zsh-completions
        zsh-autosuggestions
        zsh-syntax-highlighting
    )
fi

### path settings ###
try_path=(
   ~/.cargo/bin
   ~/.local/bin
   ~/opt/go/bin
   ~/opt/android-sdk-linux/platform-tools
   ~/.npm-packages/bin
)

for p in $try_path; do
    [ -d $p ] && path+=$path
done
# add sudo bin so that zsh-syntax-hilighting works on sudo commands
path+=(/usr/local/sbin /usr/sbin /sbin)

### plugins settings ###
# virtualenvwrapper settings
export WORKON_HOME=$HOME/.virtualenvs
# zsh-git-prompt settings
# git-prompt compiled in haskell is 4 times faster than standard python one
[ -f $ZSH_CUSTOM/plugins/zsh-git-prompt/src/.bin/gitstatus ] && \
    GIT_PROMPT_EXECUTABLE="haskell"
# required for zsh-completions
autoload -U compinit && compinit

### start oh-my-zsh and all plugins ###
source $ZSH/oh-my-zsh.sh

### plugins settings ###
# vi-mode settings
KEYTIMEOUT=1
# debian plugin settings (aliases)
apt_pref=apt
# disable pasted text highlighting (used to be slow)
# https://github.com/zsh-users/zsh-autosuggestions/issues/141#issuecomment-210615799
zstyle ':bracketed-paste-magic' active-widgets '.self-*'

# do not hilight text pasted from kill buffer
# https://github.com/zsh-users/zsh/blob/ac0dcc9a63dc2a0edc62f8f1381b15b0b5ce5da3/NEWS#L37-L42
zle_highlight+=(paste:none)

# alias-tips settings
export ZSH_PLUGINS_ALIAS_TIPS_EXCLUDES="_ ll vi please help"
export ZSH_PLUGINS_ALIAS_TIPS_EXPAND=1

# autosuggestions settings
# make forward-char accept single character (vi-mode does not work as expected)
ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=( end-of-line vi-end-of-line vi-add-eol )
ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS=(
    forward-word vi-forward-word vi-forward-word-end
    vi-forward-blank-word vi-forward-blank-word-end
    forward-char vi-forward-char
)
# I added custom widget to handle pressing enter
# so it need to be registered
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(reset-prompt-accept-line)

HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND=bg=none
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND=bg=none

# TODO: switch to ripgrep
export FZF_DEFAULT_OPTS='--cycle --filepath-word -e'
_exists ag && \
    export FZF_DEFAULT_COMMAND='ag -f --hidden --ignore .git -g ""' && \
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

### env settings ###
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export TMPDIR=/tmp
_exists vim && export EDITOR=vim || export EDITOR=vi
export LESS='-MRiS#8j.5'
# make less hilight source code http://superuser.com/a/71593/240371
[ -f /usr/share/source-highlight/src-hilite-lesspipe.sh ] && \
    export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

### key bindings ###
# ctrl + arrows
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word
# alt + arrows
bindkey '^[[1;3D' backward-word
bindkey '^[[1;3C' forward-word
# ctrl+del/backspace
bindkey '^H' backward-kill-word # this does not work in tmux (ctrl+h conflict)
bindkey '^[[3;5~' kill-word

# shift+tab
bindkey '^[[Z' reverse-menu-complete

# vi mode is cool but restore some common shortcuts in insert mode
bindkey '^f' forward-char
bindkey '^b' backward-char
bindkey '^[b' backward-word
bindkey '^[f' forward-word
bindkey '^w' backward-kill-word
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
bindkey '^k' kill-line
bindkey '^y' yank
bindkey '^u' kill-buffer

# reset prompt after pressing enter
# useful when ssh to machine not supporting prompt switching
function reset-prompt-accept-line() {
   echo -ne "\e[2 q";
   zle accept-line
}
zle -N reset-prompt-accept-line
bindkey '^M' reset-prompt-accept-line

### zsh settings ###
# stop ctrl-s from hanging terminal
setopt NO_FLOW_CONTROL

## history  ##
# Accept history expansion (ex !$) without extra key press
unsetopt HIST_VERIFY

setopt NOBEEP
setopt NUMERIC_GLOB_SORT

# The three options:
# INC_APPEND_HISTORY, INC_APPEND_HISTORY_TIME, SHARE_HISTORY
# should be considered mutually exclusive (man zshoptions).
# some older zhs do not support INC_APPEND_HISTORY_TIME
unsetopt SHARE_HISTORY
setopt INC_APPEND_HISTORY_TIME && unsetopt INC_APPEND_HISTORY || setopt INC_APPEND_HISTORY

setopt EXTENDED_HISTORY
alias history='fc -ilD 1 | less +G'

setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_SAVE_NO_DUPS
setopt HIST_EXPIRE_DUPS_FIRST

### load external files ###
# Make new terminal sessions use the current directory
[ -f /etc/profile.d/vte.sh ] && . /etc/profile.d/vte.sh

[ -f ~/.aliases ] && . ~/.aliases
[ -f ~/.gvm/scripts/gvm ] && . ~/.gvm/scripts/gvm
[ -f ~/.fzf.zsh ] && . ~/.fzf.zsh
[ -f ~/.config/nvim/nvim.sh ] && . ~/.config/nvim/nvim.sh
# all config that should not be tracked in git should go to zshlocalrc
[ -f ~/.zshlocalrc ] && . ~/.zshlocalrc
_exists rbenv && eval "$(rbenv init -)"
