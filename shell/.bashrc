alias curr='cd ~/documents/git_projects'

echo -n "Welcome: "; id -un | cat | tr -d '\n';
echo -n " "; tty | cut -c6-12 | cat
echo ""

#PS1='\[\e[0;01m\]\[$(tty | cut -c6-12)\]:\[\e[38;5;225m\]\W \[\e[0;01m\]\u\$\[\e[m\] '
export PS1='\[\e[0;01m\]\u:\[\e[38;5;225m\]\W \[\e[0;01m\]\[$(tty | cut -c6-12)\]\$\[\e[m\] '

if [ -f ~/.git-prompt.bash ]; then
  source ~/.git-prompt.bash
  export PS1='\[\e[0;01m\]\[$(tty | cut -c6-12)\]:\[\e[38;5;225m\]\W \[\e[0;01m\]\[$(__git_ps1 "%s")\]\$\[\e[m\] '
fi

export PATH='~/bin:'$PATH

export HISTCONTROL=ignoreboth         # ignoredups:ignorespaces
export HISTIGNORE='history:pwd:exit:ll:ll -a: ls: tree:tty'

function cl () {
    cd "$@" && ls -lhSrG
    }

if command -v nvim &> /dev/null
then
	alias n='nvim'
fi

function start_vn () {
	echo "cd /Users/vselin/Documents/other_stuff/books/visual_novels/Visual-Novel-OCR/backendServer"
	echo "node server.js"

	echo "cd /Users/vselin/Documents/other_stuff/books/visual_novels/Visual-Novel-OCR/backendServer"
	echo "python3 -m flash run"

	echo "cd /Users/vselin/Documents/other_stuff/books/visual_novels/Visual-Novel-OCR/userInterface"
	echo "npm start"
}

# General convenience aliases 
alias ll='ls -lhSrG '
alias home='cd ~'
alias h='history'
alias see='tree -L 1'
alias lgrep='ll -a | grep -i'
alias fnum='tree -a -L 1 | grep dir'
alias mem='top -l 1 -s 0 | grep PhysMem'
alias actlive='top -n 10 -o cpu -s 4 -i 100 -U vselin'
alias pgrep='ps aux | grep'

# Git aliases
alias gitst='git status -s'
alias git-log='git log --color=always | bless'
alias git-diff='git diff --color=always | bless'
alias gitllog='git log --graph --all --oneline --decorate --color=always | sed -n 1,5p'
alias gitlloga='git log --graph --all --oneline --decorate --color=always | bless'
alias gitdesk='github .'

# Open notes. Assumes a ~/.config/notes/ path
alias unix_notes='view ~/.config/notes/unix_notes.md'
alias git_notes='view ~/.config/notes/git_notes.md'
alias rust_ref='view ~/.config/notes/rust_ref.md'
alias util_notes='view ~/.config/notes/utility_notes.md'
alias vim_notes='util_notes'

# Navigation, very system specific
alias safe='cd ~/documents/safe_house/safe'
alias n_compsci='cl /Users/vselin/documents/git_projects/compsci/cs175'
alias n_uni='cl /Users/vselin/documents/other_stuff/uni'
alias n_commands='cl /Users/vselin/documents/git_projects/commands'
alias n_sauce='cl /Users/vselin/documents/git_projects/rust_programs/sauce'
alias n_learn='cl /Users/vselin/documents/git_projects/rust_programs/learning'
alias n_visuals='cl /Users/vselin/Documents/other_stuff/books/visual_novels/Visual-Novel-OCR'

# Considered for removal: Pasteboard convenience
alias pbcgeneral='pbcopy -pboard general'
alias pbcfind='pbcopy -pboard find'
alias pbcfont='pbcopy -pboard font'
alias pbcruler='pbcopy -pboard ruler'
alias pbpgeneral='pbpaste -pboard general'
alias pbpfind='pbpaste -pboard find'
alias pbpfont='pbpaste -pboard font'
alias pbpruler='pbpaste -pboard ruler'

# Safety remaps
alias mv='mv -i'
alias cp='cp -i'
alias rm='rm -i'
alias df='df -h'
alias du='du -h'
alias mkdir='mkdir -p'


safe

export BASH_SILENCE_DEPRECATION_WARNING=1

if [ -f ~/.git-completion.bash ]; then
  source ~/.git-completion.bash
fi
