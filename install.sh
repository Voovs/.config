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
    for file in .{bash_profile,bash_env,bash_aliases,bash_prompt,bash_functions}; do
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
    # Make a vim directory
    [[ -d ~/.vim ]] || ln -s $PWD/editor/.vim ~

    editor_dir=$PWD'/editor'

    # Link vimrc
    [[ -e ~/.vimrc ]] || ln -s $editor_dir/.vimrc ~/.vimrc

    # Link common vim config file
    cvim='/.vim/common_init.vim'
    [[ -e ~/${cvim} ]] || ln -s ${editor_dir}${cvim} ~/.vim

    # Link neovim configs
    nvim_path=~/'.config/nvim'
    nvim_init=$nvim_path'/init.vim'
    nvim_conf=$editor_dir'/nvim'
    [[ -d $nvim_path ]] || mkdir -p $nvim_path
    [[ -e $nvim_init ]] || ln -s $nvim_conf/init.vim $nvim_init
    [[ -e $nvim_path/plugin ]] || ln -s $editor_dir/.vim/plugin $nvim_path
    unset nvim_init; unset nvim_conf; unset nvim_path

    # Link vim colorscheme
    vim_colors=$editor_dir'/.vim/colors'
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
    if [[ ! -d ~/.vim/plugin ]]; then 
        ln -s $editor_dir'/.vim/plugin' ~/.vim/plugin
    else
        [[ -d ~/.vim/plugin/statusbars ]] || mkdir -p ~/.vim/plugin/statusbars

        # Link statusline and tabline
        for line_name in {statusline,tabline}'.vim'; do
            line_path='.vim/plugin/statusbars/'$line_name

            [[ -e ~/$line_path ]] && echo 'You already have a' $line_name \
            || ln -s $PWD/editor/$line_path ~/$line_path

            unset line_path
        done
    fi

    unset editor_dir
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
if [[ ! -e $safe/configs ]]; then
    ln -s $PWD $safe/configs
else
    echo 'Failed to link configs in routing directory'
    echo 'Aliases from notes won'"'"'t work. Remove them from ~/.bash_aliases'
fi
unset safe


# ==========================================================
# External dependencies
# ==========================================================
read -p 'Would you like to install external packages? [y/N] ' -r

if [[ $REPLY =~ ^[Yy]$ ]]; then
    packages=('git' 'bat' 'nvim' 'tree' 'github' 'exa' 'alacritty' 'fzf' 'tmux')

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
