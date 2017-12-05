_exists() { type "$1" >/dev/null }

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
   ~/.cabal/bin
   ~/.cargo/bin
   ~/.local/bin
   ~/opt/go/bin
   ~/opt/android-sdk-linux/platform-tools
   ~/.npm-packages/bin
)

for p in $try_path; do
    [ -d $p ] && path=($p $path)
done

# add sudo bin so that zsh-syntax-hilighting works on sudo commands
path=(
   $path
   /usr/local/sbin /usr/sbin /sbin
)

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
zle_highlight=(none)

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

export FZF_DEFAULT_OPTS='--cycle --tiebreak=end,length'
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
# shift+tab
bindkey '^[[Z' reverse-menu-complete
# ctrl+del/backspace, this does not work in tmux
bindkey '^H' backward-kill-word # # ctrl+h conflict in tmux
bindkey '^[[3;5~' kill-word
# TODO: alt+del alt+backspace
# vi mode is ok but restore common shortcuts in insert mode
bindkey '^f' forward-char
bindkey '^b' backward-char
bindkey '^[b' backward-word
bindkey '^[f' forward-word
bindkey '^w' backward-kill-word
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
bindkey '^k' kill-whole-line
bindkey '^y' yank
#bindkey '^t' transpose-chars
bindkey '^[t' transpose-words
bindkey '^u' undo

# reset prompt after pressing enter
function reset-prompt-accept-line() {
   echo -ne "\e[2 q";
   zle accept-line
}
zle -N reset-prompt-accept-line
bindkey '^M' reset-prompt-accept-line

# stop ctrl-s from hanging terminal
# http://unix.stackexchange.com/questions/72086/ctrl-s-hang-terminal-emulator
stty -ixon

### history ###
# man zshoptions
unsetopt histverify
unsetopt share_history
unsetopt inc_append_history
setopt inc_append_history_time &>/dev/null
alias history='fc -ilD 1 | less +G'

# prevent error commands to be inserted to history file
# http://superuser.com/questions/902241/how-to-make-zsh-not-store-failed-command
# zshaddhistory() { whence ${${(z)1}[1]} >| /dev/null || return 1 }

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

true

