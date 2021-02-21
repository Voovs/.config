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
    dotfiles={bash_profile,bash_env,bash_aliases,bash_prompt,bash_functions}

    for file in .$dotfiles; do
        if [[ ! -e ~/$file ]]; then
            ln -s $PWD'/shell/bash/'$file ~/$file
        else
            echo 'Failed to link:'  $file
        fi
    done
fi


# Vim directory setup
#
# Sets up colorscheme and useful plugin files
read -p 'Would you like to softlink vim configs? [Y/n] ' -r
if [[ ! $REPLY =~ ^[Nn]$ ]]; then
    # Link vim colorscheme
    vim_colors=$PWD'/editor/vim/colors'
    if [[ ! -d ~/.vim/colors ]]; then
        ln -s $vim_colors ~/.vim/colors
    elif [[ ! -e ~/.vim/colors/base16-gruvbox-dark-pale.vim ]]; then
        ln -s $vim_colors/base16-gruvbox-dark-pale.vim \
            ~/.vim/colors/base16-gruvbox-dark-pale.vim
    else
        echo 'Color scheme already exists'
    fi
    unset vim_colors

    # Set up statsline and tabline
    [[ -d $HOME/.vim/plugin/statusbars ]] || mkdir -p $HOME/.vim/plugin/statusbars

    # Link statusline and tabline
    for line_name in {statusline,tabline}'.vim'; do
        line_path='.vim/statusbars/'$line_name

        [[ -e ~/$line_path ]] && echo 'You already have a' $line_name \
        || ln -s $PWD/editor/$line_path ~/$line_path

        unset line_path
    done
fi

# Alacritty config setup
alacritty_p=~/'.config/alacritty'
acry_conf=$alacritty_p'/alacritty.yml'
[[ -d $alacritty_p ]] || mkdir -p $alacritty_p
[[ -e $acry_conf ]] || ln -s $PWD/gui/alacritty/alacritty.yml $acry_conf
unset acry_conf
unset alacritty_p


# Make a "safe" routing directory
#
# The idea behind a routing directory is being able to quickly navigate
# anywhere relevent in your system. It's a very quick alias to type for
# navigation, one finger per key on the left hand, and allows you to setup
# temporary softlinks with easy.  I use this a lot when I'm working on several
# projects concurrently
safe=~/'.safe_house/safe'
[[ -d $safe ]] || mkdir -p ~/.safe_house/safe
[[ -e $safe/configs ]] || ln -s $PWD $safe/configs
unset safe


# ==========================================================
# External dependencies
# ==========================================================
read -p 'Would you like to install external packages? [y/N] ' -r

if [[ $REPLY =~ ^[Yy]$ ]]; then
    packages=('git' 'bat' 'nvim' 'tree' 'github' 'exa' 'alacritty')

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
