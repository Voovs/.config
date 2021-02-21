function cl () {
    cd "$@" && ls -lhSrG
}

# Colored pagenation. Requires the `bat` pagenator
function bless () {
    bat "$@" --color=always $1 | less -r
}

