__GIT_PROMPT_DIR="${0:A:h}"

## Hook function definitions
function chpwd_update_git_vars() {
    update_current_git_vars
}

function preexec_update_git_vars() {
    case "$2" in
        git*|hub*|gh*|stg*)
            __EXECUTED_GIT_COMMAND=1
            ;;
    esac
}

function precmd_update_git_vars() {
    if [ -n "$__EXECUTED_GIT_COMMAND" ]; then
        update_current_git_vars
        unset __EXECUTED_GIT_COMMAND
    fi
}

chpwd_functions+=(chpwd_update_git_vars)
precmd_functions+=(precmd_update_git_vars)
preexec_functions+=(preexec_update_git_vars)

## Function definitions
function update_current_git_vars() {
    unset __CURRENT_GIT_STATUS
    unset GIT_DIR
    unset GIT_BRANCH
    unset GIT_DIRTY

    gitstatus="$(git status --porcelain --branch 2>/dev/null)"
    if [ $? -eq 0 ]; then
        GIT_DIR=1
        GIT_BRANCH="$(echo ${gitstatus} | sed -n 1p | cut -d' ' -f 2 | cut -d'.' -f 1)"
        if [ ! -z "$(echo ${gitstatus} | sed -n 2p)" ]; then
            GIT_DIRTY=1
        fi
    fi
}

git_prompt_dirty() {
    if [ ! -z "$GIT_DIR" ]; then
        if [ ! -z "$GIT_DIRTY" ]; then
            echo "$ZSH_THEME_GIT_PROMPT_DIRTY"
        else
            echo "$ZSH_THEME_GIT_PROMPT_CLEAN"
        fi
    fi
}

git_prompt_branch() {
    if [ ! -z "$GIT_DIR" ]; then
        echo "$ZSH_THEME_GIT_PROMPT_BRANCH_PREFIX$GIT_BRANCH$ZSH_THEME_GIT_PROMPT_BRANCH_SUFFIX%{$reset_color%}"
    fi
}

git_prompt_update() {
    update_current_git_vars
}

# Default values for the appearance of the prompt.
ZSH_THEME_GIT_PROMPT_BRANCH_PREFIX="(%{$fg_bold[magenta]%}"
ZSH_THEME_GIT_PROMPT_BRANCH_SUFFIX="%{$reset_color%})"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fb_bold[green]%}✔ %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fb_bold[red]%}✗ %{$reset_color%}"
