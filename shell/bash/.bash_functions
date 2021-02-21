function cl () {
    cd "$@" && ll
}

# Colored pagenation. Requires the `bat` pagenator
function bless () {
    bat "$@" --color=always $1 | less -r
}

