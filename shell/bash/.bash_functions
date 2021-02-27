function cl () {
    cd "$@" && ll
}

# Colored pagenation. Requires the `bat` pagenator
function bless () {
    bat --color=always $1 | less -r
}

# Greps file and directory names in given directory for a pattern. If no
# directory is provided, the present working directory is used
# Examples:
#   $ lgrep ~ bash
#   $ lgrep bash
function lgrep () {
    if [[ -n $1 ]] && [[ -n $2 ]]; then 
        ll -a $1 | grep -i $2
    elif [[ -n $1 ]]; then
        ll -a $PWD | grep -i $1
    else
        echo 'USAGE:'
        echo '    lgrep [dir] <pattern>'
    fi
}

