# File system interaction
##    Bare basics
##    Creating and removing
##    Patitions, Volumes, and External disks
# System managment
##    Permissions
##    Unix info
##    Processes
##    Configs
# Programs
##    Basic programs
##    Utilities
##    Advanced programs
##    Scripting
##    OSX tools
##    Custom programs


#File system interaction
##Bare basics
cd [dir]

ls -lhSrG [optional_file]
tree -L 3
du -had 2 [dir_name]

cat [file] [optional_file]
less [file]

pwd

find [path] -name ["name_here"] -and -not [name]

##Creating and removing
touch [file]

mkdir [dir_name]

mv [file/dir_name] [name_file/dir_name]
-nfiv

cp [start_file] [new_file]
cp -R [start_dir] [new_dir]
-nfiv

rm [file_name]
rm -R [dir_name]
rmdir [empty_dir_name]

ln [file/dir_name] [hardlink_name]
ln -s [file/dir] [symboliclink_name]

##Patitions, Volumes, and External disks
df -h *currently mounted*
diskutil list

diskutil mount disk1s6
diskutil apfs unlockVolume disk1s6 *locked*

diskutil unmount disk1s6

#System managment
##Permissions
sudo
sudo -k *exit sudo auto-login*

chown [user]:[group] [file_name]
chown [user]:[group] [dir_name]

chmod ugo=rwx [file_name]
chmod -R g+w [dir_name]
OR ==> r = 4, w = 2, x = 1, sum = permissions
chmod 733 [file_name]
*sudo necessary in most cases*

##Unix info
whereis
which (version in use)
whatis
whoami

uptime

tty

system_profiler SPSoftwareDataType

##Processes
ps aux

top -n 10 -o cpu -s 4 -i 100 -U vselin
*actlive alias on this system*

kill [process_id]
kill -9 [process_id]

Typical exit commands:
q, x, ^q, ^x, esc
Force quit: ^c

##Configs
alias [alias]="[command_w_args?]"
unalias [alias]

source [file/.bashrc]

export MYVAR='stuffs'

export PS1='\[\e[0;01m\]\u:\[\e[38;5;225m\]\W \[\e[0;01m\]\[$(tty | cut -c6-12)\]\$\[\e[m\] '
*write in .bashrc and source from .bash_profile at startup*

#Programs
##Basic programs
grep -E
grep -Rl [regex] [directory/file_regex]
:: history | grep nano | wc

open -R [file/dir]
open -a [app]

diff -u [file] [changed_file] | diffstat
      [num]d[num]
      [num]a[num]
      [num]c[num]
diff -r [dir] [changed_dir]

##Utilities
cal [month] [year]
cal -y [year]
date
uptime

nano [file_name]
vim *see utility_notes*

wc
units
bc *see utility_notes*

cat ~/.bash_history
history
history -d [num]
![num]
!-[num]
![start_letters_in_command]
!!
!$

##Advanced programs
tr [regex] [string] < [file]
tr -dsc [expression] < [feed_file] > [out_file]

sed -E "s—[curr_regex]—[new_str]—g" < [in_file]
sed -e "s/[curr_regex]/[new_str]/g" -e "s/[curr_regex]/[new_str]/g" < [in_file]

cut -c 1-2 < [file]
cut -f 1-2 -d [char] < [file]

[args_command] | xargs
[args_command] | xargs -t -n1 [command]
[args_file] | xargs -p -0 -I {} [command] "string {}"

##Scripting
[command_w_args] > [file_overwrite]
[command_w_args] >> [file_append]
[command] < [in_file]
[command_w_args] < [in_file] > [out_file]

[command] | [command] | [command]

[command_w_out] > /dev/null

##OSX tools
pbcopy
      general
      find
      font
      ruler
pbpaste

say [str]

##Custom programs
bless [file] 

blacklist --help

nh [6-digit num]





sw331
