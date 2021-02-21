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
# Softlinks bash dotfiles
read -p 'Try to softlink bash dotfiles? [Y/n] ' -r
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


# Vim directory setup
#
# Sets up colorscheme and useful plugin files
read -p 'Would you like to softlink vim configs? [Y/n] ' -r
if [[ ! $REPLY =~ ^[Nn]$ ]]; then
    # Make sure a colors directory exists
    [[ -d $HOME/.vim/colors ]] || mkdir -p $HOME/.vim/colors

    if [[ ! -e "$HOME/.vim/colors/base16-gruvbox-dark-pale.vim" ]]; then
        ln -s "$PWD/editor/.vim/colors/base16-gruvbox-dark-pale.vim" \
            "$HOME/.vim/colors/base16-gruvbox-dark-pale.vim"
    else
        echo 'Color scheme already exists!'
    fi

    # Set up statsline and tabline
    [[ -d $HOME/.vim/plugin/statusbars ]] || mkdir -p $HOME/.vim/plugin/statusbars

    if [[ ! -e "$HOME/.vim/plugin/statusbars/statusline.vim" ]]; then
        ln -s "$PWD/editor/.vim/plugin/statusbars/statusline.vim" \
            "$HOME/.vim/plugin/statusbars/statusline.vim"
    else
        echo 'You already have a statusline.vim'
    fi

    if [[ ! -e "$HOME/.vim/plugin/statusbars/tabline.vim" ]]; then
        ln -s "$PWD/editor/.vim/plugin/statusbars/tabline.vim" \
            "$HOME/.vim/plugin/statusbars/tabline.vim"
    else
        echo 'You already have a tabline.vim'
    fi
fi


# Make a "safe" routing directory
#
# The idea behind a routing directory is being able to quickly navigate
# anywhere relevent in your system. It's a very quick alias to type for
# navigation, one finger per key on the left hand, and allows you to setup
# temporary softlinks with easy.  I use this a lot when I'm working on several
# projects concurrently
read -p 'Would you like to set up a routing point "safe" directory? [y/N] ' -r

if [[ $REPLY =~ ^[Yy]$ ]]; then
    [[ -d ~/.safe_house/safe ]] || mkdir -p ~/.safe_house/safe

    # Make a link to configs in routing directory
    ln -s $PWD ~/.safe_house/safe

    # Setup alias for safe
    {
        echo
        echo '# Alias to routing directory'
        echo 'alias safe='"'"'cl ~/.safe_house/safe'"'"''
    } >> ~/.bash_aliases

    # Start in routing directory on login
    {
        echo
        echo '# Start in routing directory on login'
        echo 'safe'
    } >> ~/.bash_profile
    echo 'You'"'"'ll start in `~/.safe_house/safe`'
fi


# Aliases for quickly viewing notes
#
# These aliases are great when you need to quickly reference something, instead
# of doing any intensive reading. This is the only instance I see notes being
# more useful than an online search
read -p 'Would you like aliases for accessing notes? [y/N] ' -r
if [[ $REPLY =~ ^[Yy]$ ]]; then
    # Append aliases with comments
    {
        echo
        echo '# Quickly read notes. Depends on fn from .bash_functions'
        echo "if command -v bless &> /dev/null"
        echo 'then'
        echo "    alias unix_notes='bless $PWD/notes/unix_notes.md'"
        echo "    alias good_reads='bless $PWD/notes/reads.md'"
        echo "    alias git_notes='bless $PWD/notes/git_notes.md'"
        echo "    alias rust_ref='bless $PWD/notes/rust_ref.md'"
        echo "    alias util_notes='bless $PWD/notes/utility_notes.md'"
        echo "    alias vim_notes='util_notes'"
        echo 'fi'
    } >> ~/.bash_aliases
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
