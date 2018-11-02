gitstatus="$(git status --porcelain --branch 2>/dev/null)"
if [ $? -eq 0 ]; then
    GIT_DIR=1
    GIT_BRANCH="$(echo ${gitstatus} | cut -d' ' -f 2 | cut -d'.' -f 1)"
    if [ ! -z "$(echo ${gitstatus} | sed -n 2p)"]; then
        GIT_DIRTY=1
    fi
fi

echo "$GIT_DIR $GIT_BRANCH $GIT_DIRTY"
echo "$gitstatus\n$(echo ${gitstatus} | cut -d'M' -f 2)"
