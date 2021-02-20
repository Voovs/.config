#!/bin/bash
if [[ -d "$PWD/.git" ]]; then
    echo 'Hello! This script will try to setup up your system configuration'
    echo '================================================================='
else
    echo 'Please move to the same directory as you cloned the git repository'
    exit
fi

# ==========================================================
# Soft link config files. Warn about conflicts
# ==========================================================
read -p 'Try to softlink config files? [Y/n] ' -r

if [[ ! $REPLY =~ ^[Nn] ]]; then
    echo 'Attemping to link files...'

    file_names=(\
        '.bash_profile' \
        '.bash_env' \
        '.bash_aliases' \
        '.bash_prompt' \
        '.bash_functions')
    file_paths=(\
        $PWD'/shell/bash/.bash_profile' \
        $PWD'/shell/bash/.bash_env' \
        $PWD'/shell/bash/.bash_aliases' \
        $PWD'/shell/bash/.bash_prompt' \
        $PWD'/shell/bash/.bash_functions')

    failed_links=()

    # Will try to make a symbolic link
    try_link() {
        if [[ ! -f "$HOME/$FNAME" ]]; then
            ln -s $FPATH $HOME/$FNAME
            echo 'Tried to link  '$FNAME
        else
            failed_links+=("$FNAME")
        fi
    }

    # Tries to symbolically link all the files in the arrays
    file_cnt=${#file_names[@]}
    for ((i = 0; i < file_cnt; i++)); do
        FNAME=${file_names[i]}
        FPATH=${file_paths[i]}
        try_link
    done

    # Error message for files with already exist
    for link in "${failed_links[@]}"; do
        echo 'Failed to link:  '$link
    done
fi


# Make a "safe" routing directory
if [[ ! -d "$HOME/.safe_house" ]]; then
    read -p 'Would you like to set up a routing point "safe" directory? [Y/n] ' -r

    if [[ ! $REPLY =~ ^[Nn]$ ]]; then
        #mkdir ~/.safe_house
        #mkdir ~/.safe_house/safe
        #ln -s $PWD ~/.safe_house/safe
        #echo 'alias safe='"'"'cl ~/.safe_house/safe'"'"'' >> ~/.bash_profile
        #echo 'safe' >> ~/.bash_profile
        echo 'You'"'"'ll start in `~/.safe_house/safe`'
    fi

    read -p 'Would you like aliases for accessing notes? [y/N] ' -r
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        #TODO: make this a list
        echo "if command -v bat &> /dev/null" >> ~/.bash_aliases
        echo 'then' >> ~/.bash_aliases
        echo '    # Colored pagenation' >> ~/.bash_aliases
        echo '    alias bless='"'"'bat --color=always $1 | less -r' >> ~/.bash_aliases

        echo '    # Quickly read notes' >> ~/.bash_aliases
        echo "    alias unix_notes='bless $PWD/notes/unix_notes.md'" >> ~/.bash_aliases
        echo "    alias git_notes='less $PWD/notes/git_notes.md'" >> ~/.bash_aliases
        echo "    alias rust_ref='less $PWD/notes/rust_ref.md'" >> ~/.bash_aliases
        echo "    alias util_notes='bless $PWD/notes/utility_notes.md'" >> ~/.bash_aliases
        echo "    alias vim_notes='util_notes'" >> ~/.bash_aliases
        echo 'fi' >> ~/.bash_aliases
    fi
fi


# ==========================================================
# External dependencies
# ==========================================================
read -p 'Would you like to install external packages? [y/N] ' -r

if [[ $REPLY =~ ^[Yy]$ ]]; then
    packages=('git' 'bat' 'nvim' 'tree' 'github' 'exa')

    # Find supported package manager
    if command -v pacman &> /dev/null; then
        PACMAN='sudo pacman -S'
    elif command -v paru &> /dev/null; then
        PACMAN='paru -S'
    elif command -v brew &> /dev/null; then
        PACMAN='brew install'
    else
        echo 'No package manager found'
        echo
        echo 'You can install these yourself: '
        for package in "${packages[@]}"; do
            echo '  - '$package
        done

        exit
    fi


    # Asks for confirmation before running package manager
    prompt_install() {
        if ! command -v $package &> /dev/null; then
            read -p "Would you like to install ${package}? [Y/n] " -r
            if [[ ! $REPLY =~ ^[Nn] ]]; then
                echo 'Installing' $package 'with' $PACMAN
                #eval $PACMAN $cmd
            fi
        else
            echo 'Didn'"'"'t need to install' $package 'with' $PACMAN
        fi
    }

    # Asks to install each package, one at a time
    for ((i = 0; i < ${#packages[@]}; i++)); do
        package=${packages[i]}
        prompt_install
    done
fi

source ~/.bash_profile
