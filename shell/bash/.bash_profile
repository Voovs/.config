# Source all bash related files
# Adapted from https://github.com/mathiasbynens/dotfiles/blob/main/.bash_profile
for file in ~/.{bash_prompt,bash_env,bash_aliases,bash_functions}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

if [ -f ~/.git-completion.bash ]; then
  source ~/.git-completion.bash
fi

# Welcome prompt
echo -n 'bash shell'
if [[ `uname` == 'Darwin' ]]; then
    echo -n " on OSX "; sw_vers -productVersion;
elif [[ `uname` == 'Linux' ]]; then
    os_name=`cat /etc/os-release \
        | awk 'match($0, /PRETTY_NAME/) {print substr($0, RLENGTH + 3);}' \
        | rev | cut -c 2- | rev`
    echo -n " on $os_name"
fi

echo
cal
# Welcome: username ttys###
# Welcome: vselin ttys000
echo "Welcome: $(id -un | cat | tr -d '\n') $(tty | cut -c6-14 | cat)"
echo 


# Setting PATH for Python 3.8
# The original version is saved in .bash_profile.pysave
# PATH="/Library/Frameworks/Python.framework/Versions/3.8/bin:${PATH}"
# export PATH

# Start in routing directory on login
cd ~/.safe_house/safe
