
reset="%{$reset_color%}"
fade="%{\x1b[2m%}"
italic="%{\x1b[3m%}"
underline="%{\x1b[4m%}"
bracket="%{$fg_bold[blue]%}"
branch="%{$fg_bold[green]%}"
clean_color="%{$fg[green]%}"
dirty_color="%{$fg[green]%}"
open=" ("
close=")"
clean="✔"
dirty="✗"

# ZSH_THEME_GIT_PROMPT_BRANCH_PREFIX="${bracket}${open}${style}${branch}"
# ZSH_THEME_GIT_PROMPT_BRANCH_SUFFIX="${bracket}${close}"
# ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}${clean}%{$reset_color%}"
# ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%}${dirty}%{$reset_color%}"

ZSH_THEME_GIT_PROMPT_BRANCH_PREFIX=""
ZSH_THEME_GIT_PROMPT_BRANCH_SUFFIX="${reset}${bracket}${close}"
ZSH_THEME_GIT_PROMPT_CLEAN="${bracket}${open}${clean_color}"
ZSH_THEME_GIT_PROMPT_DIRTY="${bracket}${open}${dirty_color}${italic}${fade}"

git_prompt_status() {
    git_prompt_update
    echo "$(git_prompt_dirty)$(git_prompt_branch)"
}

git_status="$(git_prompt_dirty)"

success="◎"
error="◉"
local ret_status="%(?:%{$fg_bold[green]%}${success}:%{$fg_bold[red]%}${error})"
PROMPT='$(git_prompt_status) %{$fg[blue]%}%~ ${ret_status}%{$reset_color%} '

