export FZF_COMPLETION_OPTS='-1 -0 --ansi'

_fzf_complete_la() {
    _fzf_complete "--multi" "$@" < <(
        ls -a -1 --color=always | tail -n +3 -f
    )
}

_fzf_complete_ls() {
    _fzf_complete "--multi -n 9" "$@" < <(
        ls -lFh --color=always | tail -n +2 -f
    )
}
_fzf_complete_ls_post() { awk '{print $9}'; }

_is_git_repo() {
    git rev-parse --is-inside-work-tree > /dev/null 2>&1
}

_fzf_complete_ga() {
    _is_git_repo &&
    FZF_COMPLETION_OPTS='-0 --ansi' _fzf_complete "--multi -n 2 " "$@" < <(
        git -c color.status=always status --short
    )
}
_fzf_complete_ga_post() { awk '{print $2}'; }

_fzf_complete_gru() {
    _is_git_repo && _fzf_complete "--multi" "$@" < <(
        git diff --name-only --cached
    )
}

_fzf_complete_grs() {
    _is_git_repo && _fzf_complete "--multi" "$@" < <(
        git diff --name-only --diff-filter=M
    )
}

_fzf_complete_gd() {
    _is_git_repo && _fzf_complete "--multi" "$@" < <(
        git diff --name-only --diff-filter=M
    )
}

_fzf_complete_gds() {
    _is_git_repo && _fzf_complete "--multi" "$@" < <(
        git diff --staged --name-only --diff-filter=M
    )
}

_fzf_complete_gco() {
    _is_git_repo && _fzf_complete "--no-multi -n 2" "$@" < <(
        git for-each-ref --sort=-committerdate refs/heads/ --format="br %(refname:short)"
        git for-each-ref --sort=-committerdate refs/remotes/ --format="rbr %(refname:short)"
        git for-each-ref --sort=-committerdate refs/tags/ --format="tag %(refname:short)"
    )
}
_fzf_complete_gco_post() { awk '{print $2}'; }

_fzf_complete_man() {
    _fzf_complete "--no-multi -n 1" "$@" < <(
        local tokens=(${(z)@})
        if [[ ${#tokens} -ge 2 && "${tokens[2]}" =~ ^[1-9]$ ]]; then
            eval man -k "-s ${tokens[2]}" .
        else
            man -k .
        fi
    )
}
_fzf_complete_man_post() { awk '{print $1}'; }


# from fzf
_fzf_complete_ssh() {
  _fzf_complete '+m' "$@" < <(
    setopt localoptions nonomatch
    command cat <(cat ~/.ssh/config ~/.ssh/config.d/* /etc/ssh/ssh_config 2> /dev/null | command grep -i '^\s*host\(name\)\? ' | awk '{for (i = 2; i <= NF; i++) print $1 " " $i}' | command grep -v '[*?]') \
        <(command grep -oE '^[[a-z0-9.,:-]+' ~/.ssh/known_hosts | tr ',' '\n' | tr -d '[' | awk '{ print $1 " " $1 }') \
        <(command grep -v '^\s*\(#\|$\)' /etc/hosts | command grep -Fv '0.0.0.0') |
        awk '{if (length($2) > 0) {print $2}}' | sort -u
  )
}

_fzf_complete_export() {
  _fzf_complete '-m' "$@" < <(
    declare -xp | sed 's/=.*//' | sed 's/.* //'
  )
}
_fzf_complete_unset() {
  _fzf_complete '-m' "$@" < <(
    declare -xp | sed 's/=.*//' | sed 's/.* //'
  )
}
_fzf_complete_unalias() {
  _fzf_complete '+m' "$@" < <(
    alias | sed 's/=.*//'
  )
}
