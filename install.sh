#!/bin/bash
echo 'Hello! This script will try to setup up your system configuration'
echo '================================================================='
echo 'First, make sure you'"'"'re in the right directory'
read -p "Is ${PWD} the directory you cloned into? [y/N] " -r
if [[ ! $REPLY =~ ^[Yy] ]]; then
    echo 'Please navigate to that directory first'
    exit
fi

# ==========================================================
# Soft link config files. Warn about conflicts
# ==========================================================
read -p 'Try to softlink config files? [Y/n] ' -r

if [[ ! $REPLY =~ ^[Nn] ]]; then
    echo 'Attemping to link files...'

    file_names=('.bashrc' '.bash_profile')
    file_paths=('shell/bash/.bashrc' 'shell/bash/.bash_profile')

    failed_links=()

    # Will try to make a symbolic link
    try_link() {
        if [[ ! -f "$HOME/$FNAME" ]]; then
            #ln -s $PWD/$FPATH $HOME/$FNAME
            echo 'Tried to link'$FNAME
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
        #echo 'alias safe='"'"'cd ~/.safe_house/safe'"'"'' >> ~/.bashrc
        #echo 'safe' >> ~/.bashrc
        echo 'You'"'"'ll start in `~/.safe_house/safe`'
    fi
fi


# ==========================================================
# External dependencies
# ==========================================================
read -p 'Would you like to install external packages? [y/N] ' -r

if [[ $REPLY =~ ^[Yy]$ ]]; then
    packages=('git' 'bat' 'nvim')

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

exit
