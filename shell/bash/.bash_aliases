# Might be necessary for vim
shopt -s expand_aliases

# Built-in aliases
alias ll='ls -lhSrG '
alias home='cd ~'
alias h='history'
alias lgrep='ll -a | grep -i'
alias mem='top -l 1 -s 0 | grep PhysMem'
alias actlive='top -n 10 -o cpu -s 4 -i 100 -U vselin'

# ls on macOS is too old to support --color
if [[ `uname` == 'Linux' ]]; then
    alias ll='ls -lhSrG --color'
fi

# Git
alias gitst='git status -s'
alias gitllog='git log --graph --all --oneline --decorate --color=always | sed -n 1,5p'
alias gitlloga='git log --graph --all --oneline --decorate --color=always | bless'
alias gitdesk='github .'

if command -v bat &> /dev/null
then
    # Colored pagenation
    alias bless='bat --color=always $1 | less -r'

    # Quickly read notes
    alias unix_notes='bless ~/documents/safe_house/safe/sh_data/notes/unix_notes.md'
    alias git_notes='bless ~/documents/safe_house/safe/sh_data/notes/git_notes.md'
    alias rust_ref='bless ~/documents/safe_house/safe/sh_data/notes/rust_ref.md'
    alias util_notes='bless ~/documents/safe_house/safe/sh_data/notes/utility_notes.md'
    alias vim_notes='util_notes'
fi

# Safety aliases
alias mv='mv -i'
alias cp='cp -i'
alias rm='rm -i'
alias df='df -h'
alias du='du -h'
alias mkdir='mkdir -p'

if command -v nvim &> /dev/null
then
    alias n='nvim'
fi

