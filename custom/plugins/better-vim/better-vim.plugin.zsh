
# change to vim mode
# bindkey -v
# makes the switch time faster
# export KEYTIMEOUT=1

bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search
bindkey -M menuselect '^[[Z' reverse-menu-complete
bindkey "^k" up-line-or-beginning-search
bindkey "^j" down-line-or-beginning-search
bindkey -M vicmd "k" up-line-or-beginning-search
bindkey -M vicmd "j" down-line-or-beginning-search

# makes vim mode correspond to a cursor
# function zle-line-init zle-keymap-select {
    # if [ $KEYMAP = "main" ]; then
        # echo -ne '\033[5 q'
    # else
        # echo -ne '\033[1 q'
    # fi
# }

# attach cursor change function
zle -N zle-line-init
zle -N zle-keymap-select

