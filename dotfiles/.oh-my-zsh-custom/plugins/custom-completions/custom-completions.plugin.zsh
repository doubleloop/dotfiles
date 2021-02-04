export CUSTOM_COMPLETION_OPTS='-1 -0 --ansi --no-info'

_try_custom_completion() {
    [[ $LBUFFER == *"${FZF_COMPLETION_TRIGGER-**}" ]] && return 1
    local tokens=(${(z)LBUFFER})
    local func="_fzf_complete_${tokens[1]}"
    (( $+functions[$func] )) || return 1
    local lbuf=$LBUFFER
    local prefix
    if [[ $lbuf != *' ' ]]; then
        prefix=$tokens[-1]
        lbuf=${LBUFFER:0:-$#prefix}
    fi
    $func "$lbuf"
    return
}

_fzf_custom_complete() {
    setopt localoptions nomonitor
    local fifo="${TMPDIR:-/tmp}/fzf-complete-fifo-$$"
    local opts="$1"
    local lbuf="$2"
    local func="${funcstack[2]}_func"
    local post="${funcstack[2]}_post"
    local dopts="--height 40% --reverse $FZF_DEFAULT_OPTS $CUSTOM_COMPLETION_OPTS"
    local pid
    (( $+functions[$post] )) || post=cat

    command rm -f "$fifo"
    mkfifo "$fifo"
    if (( $+functions[$func] )); then
        $func >$fifo 2>/dev/null &
        pid=$!
    else
        cat <&0 > "$fifo" 2>/dev/null &
    fi
    local matches=$(FZF_DEFAULT_OPTS="$dopts"\
                    fzf ${(Q)${(Z+n+)fzf_opts}} -q "${(Q)prefix}" <"$fifo" | $post | tr '\n' ' ')
    [[ -n "$matches" ]] && LBUFFER="$lbuf$matches"
    zle reset-prompt
    (( instant_accept )) && [[ -n $matches ]] && zle reset-prompt-accept-line
    [[ -n "$pid" ]] && kill $pid >/dev/null 2>&1
    command rm -f "$fifo"
}

_fzf_complete_j_func() { _zlua --complete }
_fzf_complete_j() { local instant_accept=1; _fzf_custom_complete "+m" "$@" }

_fzf_complete_la_func() { ls -a -1 --color=always | tail -n +3 -f }
_fzf_complete_la() { _fzf_custom_complete "-m" "$@" }

_is_git_repo() { git rev-parse --is-inside-work-tree > /dev/null 2>&1 }
_eval_git_relative() {
    local root="$(git root)"
    if [[ -z root ]]; then
        eval "${1}"
    else
        root="${root}/"
        eval "${1}" | while read -r line; do
            realpath --relative-to="$PWD" "${root}${line}"
        done
    fi
}

_fzf_complete_ga_func() { git -c color.status=always status --short }
_fzf_complete_ga() {
    _is_git_repo && FZF_COMPLETION_OPTS='-0 --ansi --no-info' \
        _fzf_custom_complete "-m -n 2 " "$@"
}
_fzf_complete_ga_post() { awk '{print $2}' }

_fzf_complete_gru_func() { _eval_git_relative "git diff --name-only --cached" }
_fzf_complete_gru() { _is_git_repo && _fzf_custom_complete "-m" "$@" }

_fzf_complete_grs_func() { _eval_git_relative "git diff --name-only --diff-filter=M" }
_fzf_complete_grs() { _is_git_repo && _fzf_custom_complete "-m" "$@" }

_fzf_complete_gd_func() { _eval_git_relative "git diff --name-only --diff-filter=M" }
_fzf_complete_gd() { local instant_accept=1; _is_git_repo && _fzf_custom_complete "-m" "$@" }

_fzf_complete_gds_func() { _eval_git_relative "git diff --staged --name-only --diff-filter=M" }
_fzf_complete_gds() { local instant_accept=1; _is_git_repo && _fzf_custom_complete "-m" "$@" }

_fzf_complete_gco_func() {
    git for-each-ref --sort=-committerdate refs/heads/ --format="br %(refname:short)"
    git for-each-ref --sort=-committerdate refs/remotes/ --format="rbr %(refname:short)"
    git for-each-ref --sort=-committerdate refs/tags/ --format="tag %(refname:short)"
}
_fzf_complete_gco() { local instant_accept=1; _fzf_custom_complete "+m -n 2" "$@" }
_fzf_complete_gco_post() { awk '{print $2}' }

_fzf_complete_man_func() {
    local tokens=(${(z)@})
    if [[ ${#tokens} -ge 2 && "${tokens[2]}" =~ ^[1-9]$ ]]; then
        eval man -k "-s ${tokens[2]}" .
    else
        man -k .
    fi
}
_fzf_complete_man() { local instant_accept=1; _fzf_custom_complete "+m -n 1" "$@" }
_fzf_complete_man_post() { awk '{print $1}' }

# some experimental fzf-tab stuff

# I do not use this because I wrap _zlua with my own function
# but just in case
zstyle ':fzf-tab:complete:_zlua:*' query-string input

zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
