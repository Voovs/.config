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
