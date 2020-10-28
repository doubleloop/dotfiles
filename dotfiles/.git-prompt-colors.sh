override_git_prompt_colors() {
    GIT_PROMPT_THEME_NAME="Custom"
    GIT_PROMPT_START_USER="${Green}\u@\h ${Yellow}\w${ResetColor}"
    GIT_PROMPT_END_USER=" \n${White}${ResetColor}$ "
    GIT_PROMPT_END_ROOT=" \n${White}${ResetColor}# "
}


reload_git_prompt_colors "Custom"
