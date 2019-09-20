# doubleloop prompt configuration

# function inspired by spaceship-zsh-theme version
# Draw prompt section (bold is used as default)
# USAGE:
#   _prompt_section <content> <color> [prefix] [suffix]
PROMPT_OPENED=false # Internal variable for checking if prompt is opened
_prompt_section() {
   local color prefix content suffix
   [[ -n $1 ]] && content="$1"    || return
   [[ -n $2 ]] && color="%F{$2}"  || color="%f"
   if (( $# >= 3 )); then prefix="$3"; else prefix=" "; fi
   if (( $# >= 4 )); then suffix="$4"; else suffix=""; fi

   echo -n "%{%B%}" # set bold
   if [[ $PROMPT_OPENED == true ]]; then
      echo -n "$prefix"
   fi
   PROMPT_OPENED=true
   echo -n "%{%b%}" # unset bold

   echo -n "%{%B$color%}" # set color
   echo -n "$content"     # section content
   echo -n "%{%b%f%}"     # unset color

   echo -n "%{%B%}" # reset bold, if it was diabled before
   echo -n "$suffix"
   echo -n "%{%b%}" # unset bold
}

prompt_user()  { _prompt_section "%n" green }
prompt_host()  { _prompt_section "@%m" green "" }
prompt_dir()   { _prompt_section "%~ " yellow }
prompt_pyenv() { _prompt_section "$(virtualenv_prompt_info)" blue  }
prompt_git()   { _prompt_section "$(git_super_status)" white }
prompt_symbol() {
   local sym_color
   if (( RET_CODE == 0 )); then sym_color=white; else sym_color=red; fi
   _prompt_section "$ " $sym_color "\n"
}
_insert_mode_prompt() { printf "\x1b[5 q\x1b]112\x07" }
_normal_mode_prompt() { printf "\x1b[2 q\x1b]112\x07" }
prompt_vi() {
   if [ -z $DISABLE_PROMPT_SWITCH ]; then
      if [ "$KEYMAP" = "vicmd" ]; then
         _normal_mode_prompt
      else
         _insert_mode_prompt
      fi
   fi
}
# just in case
fix_prompt() {
    DISABLE_PROMPT_SWITCH=1
    _normal_mode_prompt
}

drow_prompt() {
   RET_CODE=$?
   prompt_user
   prompt_host
   prompt_dir
   prompt_pyenv
   prompt_git
   prompt_vi
   prompt_symbol
}

PROMPT='$(drow_prompt)'
unset RPS1

# colored man, based on zsh plugin
# http://www.tuxarena.com/2012/04/tutorial-colored-man-pages-how-it-works/

# LESS_TERMCAP_mb: enter blinking mode
# LESS_TERMCAP_md: enter double-bright mode
# LESS_TERMCAP_me: turn off all appearance modes (mb, md, so, us)
# LESS_TERMCAP_se: leave standout mode
# LESS_TERMCAP_so: enter standout mode
# LESS_TERMCAP_ue: leave underline mode
# LESS_TERMCAP_us: enter underline mode

man() {
   env \
      LESS_TERMCAP_mb=$(printf '\e[01;31m') \
      LESS_TERMCAP_md=$(printf '\e[01;38;5;75m') \
      LESS_TERMCAP_me=$(printf '\e[0m') \
      LESS_TERMCAP_se=$(printf '\e[0m') \
      LESS_TERMCAP_so=$(printf '\e[1;27;7m') \
      LESS_TERMCAP_ue=$(printf '\e[0m') \
      LESS_TERMCAP_us=$(printf '\e[04;38;5;200m') \
      _NROFF_U=1 \
         man "$@"
}

#########################################
# Colorcodes:
# Black       0;30     Dark Gray     1;30
# Red         0;31     Light Red     1;31
# Green       0;32     Light Green   1;32
# Brown       0;33     Yellow        1;33
# Blue        0;34     Light Blue    1;34
# Purple      0;35     Light Purple  1;35
# Cyan        0;36     Light Cyan    1;36
# Light Gray  0;37     White         1;37
#########################################
