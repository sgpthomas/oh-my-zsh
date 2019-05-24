
reset="%{$reset_color%}"
fade="%{\x1b[2m%}"
italic="%{\x1b[3m%}"
underline="%{\x1b[4m%}"
bracket="%{$fg[243]%}"
branch="%{$fg_bold[green]%}"
clean_color="%{$fg[green]%}"
dirty_color="%{$fg[green]%}"
ssh_color="%{$fg[red]%}"
open="("
close=")"
clean="✔"
dirty="✗"

# ZSH_THEME_GIT_PROMPT_BRANCH_PREFIX="${bracket}${open}${style}${branch}"
# ZSH_THEME_GIT_PROMPT_BRANCH_SUFFIX="${bracket}${close}"
# ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}${clean}%{$reset_color%}"
# ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%}${dirty}%{$reset_color%}"

ZSH_THEME_GIT_PROMPT_BRANCH_PREFIX=""
ZSH_THEME_GIT_PROMPT_BRANCH_SUFFIX=""
ZSH_THEME_GIT_PROMPT_CLEAN="${clean_color}"
ZSH_THEME_GIT_PROMPT_DIRTY="${dirty_color}${italic}${fade}"

git_prompt_status() {
    git_prompt_update
    if [ ! -z "$GIT_DIR" ]; then
        echo "%F{243}$open%f$(git_prompt_dirty)$(git_prompt_branch)%F{243}$close%f"
    fi
}

is_ssh() {
    if [ ! -z $SSH_PROMPT ]; then
        echo "${bracket}(${ssh_color}$SSH_PROMPT${bracket})${reset}"
    fi
}

# time_s() {
		# date -
# }

git_status="$(git_prompt_dirty)"
success="➜"
error="⭯"
local ret_status="%(?:%{$fg_bold[green]%}${success}:%{$fg_bold[red]%}${error})"
local date="%F{243}[%D{%0l:%M}]%f"
PROMPT='
 $(is_ssh) %{$fg_bold[blue]%}%~
$(git_prompt_status) ${ret_status}%{$reset_color%} '
# RPROMPT='$(git_prompt_status)'

