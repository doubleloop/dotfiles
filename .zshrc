# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="doubleloop"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="false"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=$ZSH/custom

# virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
export KEYTIMEOUT=1

# Git prompt compiled in haskell is 4 times faster than standard python one
GIT_PROMPT_EXECUTABLE="haskell"

# Plugins
# Add wisely, as too many plugins slow down shell startup

plugins=(
    alias-tips
    common-aliases fasd colorize extract command-not-found
    vagrant
    docker
    vi-mode
    golang
    jsontools
    supervisor
    gitfast gitignore zsh-git-prompt
    debian
    pip python virtualenv virtualenvwrapper
    atom sublime
    cabal stack
    gradle
    valut
    zsh-navigation-tools
    zsh-autosuggestions
    zsh-syntax-highlighting
)

path=(
   ~/.cabal/bin
   ~/opt/go/bin
   # ~/opt/android-sdk-linux/platform-tools
   $path
   /usr/local/sbin /usr/sbin /sbin
)

source $ZSH/oh-my-zsh.sh

# colored completions
eval `dircolors`
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"

zstyle ':bracketed-paste-magic' active-widgets '.self-*'

# You may need to manually set your language environment
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export TMPDIR=/tmp

# Preferred editor for local and remote sessions
export EDITOR='nvim'

[ -f ~/.aliases ] && . ~/.aliases

# Make new terminal sessions use the current directory
[ -f /etc/profile.d/vte.sh ] && . /etc/profile.d/vte.sh

# http://superuser.com/a/71593/240371
[ -f /usr/share/source-highlight/src-hilite-lesspipe.sh ] &&
    export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"

# default settings for less. You may also want to disable line wrapping with -S
export LESS='-MRiS#8j.5'
#             |||| `- center on search matches
#             |||`--- scroll horizontally 8 columns at a time
#             ||`---- case-insensitive search unless pattern contains uppercase
#             |`----- parse color codes
#             `------ show more information in prompt

# https://github.com/zsh-users/zsh-autosuggestions/issues/118
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=( expand-or-complete )

# prevent forward-char from accepting autosuggestions completions
ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=( end-of-line vi-end-of-line vi-add-eol )

# disable pasted text highlighting
zle_highlight=(none)

# use apt for debian aliases
apt_pref=apt

# alias-tips settings
export ZSH_PLUGINS_ALIAS_TIPS_EXCLUDES="_ ll vi please help"
export ZSH_PLUGINS_ALIAS_TIPS_EXPAND=1

# make navigation tools history search select command after pressing
# enter once (not twice wich is default)
znt_list_instant_select=1

# http://unix.stackexchange.com/questions/72086/ctrl-s-hang-terminal-emulator
stty -ixon

# vi mode is ok but restore common shortcuts in insert mode
bindkey '^[[Z' reverse-menu-complete
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
bindkey '^y' yank
bindkey '^e' end-of-line
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word

bindkey '\e[1;3D' backward-word
bindkey '\e[1;3C' forward-word
bindkey '^[[3;5~' kill-word
bindkey '^h' backward-kill-word
bindkey '^k' kill-whole-line
bindkey '^t' transpose-chars
bindkey '^[t' transpose-words
bindkey '^f' forward-char
bindkey '^b' backward-char
bindkey '^[f' forward-word
bindkey '^[w' forward-word
bindkey '^[b' backward-word
bindkey '^u' undo

# autosuggestions
bindkey '^ ' autosuggest-accept
bindkey '^l' forward-word

# bindkey '^f' fzf-file-widget
# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# http://www.markhneedham.com/blog/2012/09/16/zsh-dont-verify-substituted-history-expansion-a-k-a-disabling-histverify/
unsetopt histverify
