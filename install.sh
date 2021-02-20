# Make a ~/.safe_house/safe directory for routing quickly
if [[ ! -d "$HOME/.safe_house" ]]; then
    read -p \
        'Would you like to set up a routing point "safe" directory? [Y/n] ' \
        setup_safe
    echo ''

    if [[ $setup_safe != 'n' && $setup_safe != 'no' ]]; then
        #mkdir ~/.safe_house
        #mkdir ~/.safe_house/safe
        #echo 'alias safe='"'"'cd ~/.safe_house/safe'"'"'' >> ~/.bashrc
        #echo 'safe' >> ~/.bashrc
        echo 'You'"'"'ll start in `~/.safe_house/safe`'
    fi
fi
