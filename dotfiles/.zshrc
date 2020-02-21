# utils {{{
# https://www.topbug.net/blog/2016/10/11/speed-test-check-the-existence-of-a-command-in-bash-and-zsh/
_exists() { (( $+commands[$1] )) }
# }}}

### oh-my-zsh settings ### {{{
# https://github.com/robbyrussell/oh-my-zsh/blob/master/templates/zshrc.zsh-template
export ZSH=$HOME/.oh-my-zsh
ZSH_CUSTOM=$HOME/.oh-my-zsh-custom
ZSH_THEME="doubleloop"
HYPHEN_INSENSITIVE="true"
DISABLE_AUTO_UPDATE="true"
DISABLE_AUTO_TITLE="true"
ENABLE_CORRECTION="false"
DISABLE_UNTRACKED_FILES_DIRTY="true"
HIST_STAMPS="yyyy-mm-dd"
# }}}

### Plugins ### {{{
# allow custom plugins setup
if [ -f ~/.zsh_plugins ]; then
    . ~/.zsh_plugins
else
    # Add wisely, as too many plugins slow down shell startup
    plugins=(
        tmux
        vi-mode
        alias-tips common-aliases debian
        extract
        fzf
        z.lua
        git gitignore zsh-git-prompt
        # jira
        pip python virtualenv virtualenvwrapper
        # pyenv
        # django
        golang
        zsh-nvm zsh-better-npm-completion
        # cabal stack
        rust
        gcloud
        custom-completions
        zsh-autosuggestions
        fast-syntax-highlighting
    )
fi
# }}}

### Preload plugins settings ### {{{
ZSH_TMUX_AUTOSTART="true"
ZSH_TMUX_AUTOCONNECT="false"
ZSH_TMUX_AUTOQUIT="false"
# virtualenvwrapper settings
export WORKON_HOME=$HOME/.virtualenvs
# zsh-git-prompt settings
# git-prompt compiled in haskell is 4 times faster than standard python one
[ -f $ZSH_CUSTOM/plugins/zsh-git-prompt/src/.bin/gitstatus ] && \
    GIT_PROMPT_EXECUTABLE="haskell"
export NVM_LAZY_LOAD=true
# z.lua settings
export _ZL_DATA=$HOME/.zlua/data
# }}}

source $ZSH/oh-my-zsh.sh
# required for *-completions
autoload -U compinit && compinit

### Postload plugins settings ### {{{
# disable widgets on paste (slow when pasting large text buffers)
# https://github.com/zsh-users/zsh-autosuggestions/issues/141#issuecomment-210615799
zstyle ':bracketed-paste-magic' active-widgets '.self-*'

# do not hilight pasted text
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
# defined in my custom vi-mode plugin
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(reset-prompt-accept-line)

# fzf
export FZF_DEFAULT_OPTS='--cycle --filepath-word -e'
if _exists fdfind; then
    export FZF_DEFAULT_COMMAND='fdfind --type f --hidden --follow --exclude .git'
	export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
elif _exists rg; then
	export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git" 2>/dev/null'
	export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
elif _exists ag; then
    export FZF_DEFAULT_COMMAND='ag -f --hidden --ignore .git -g "" 2>/dev/null'
	export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi
# }}}

### env settings ### {{{
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export TMPDIR=/tmp
_exists vim && export EDITOR=vim
# make less hilight source code http://superuser.com/a/71593/240371
[ -x /usr/share/source-highlight/src-hilite-lesspipe.sh ] && \
    export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
_exists rustc && export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
# }}}

### zsh settings ### {{{
# shift+tab
bindkey '^[[Z' reverse-menu-complete

# stop ctrl-s from hanging terminal
setopt NO_FLOW_CONTROL

## history  ##
HISTSIZE=100000
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
# }}}

### load external files ### {{{
# Make new terminal sessions use the current directory
[ -f /etc/profile.d/vte.sh ] && . /etc/profile.d/vte.sh

[ -f ~/.aliases ] && . ~/.aliases
[ -f ~/.gvm/scripts/gvm ] && . ~/.gvm/scripts/gvm
[ -f ~/.config/nvim/nvim.sh ] && . ~/.config/nvim/nvim.sh
# all config that should not be tracked in git should go to zshlocalrc
[ -f ~/.zshlocalrc ] && . ~/.zshlocalrc
# }}}

### path {{{
path=(~/.local/bin ~/.cargo/bin $path)

# add sudo bin so that zsh-syntax-hilighting works on sudo commands
path+=(/usr/local/sbin /usr/sbin /sbin)
# prevent duplications on path (TMUX)
# typeset -aU path
# }}}

# https://serverfault.com/a/803321
export LIBVIRT_DEFAULT_URI=qemu:///system
