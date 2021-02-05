# bc
# Vim
##    Navigation
##    Insert and delete
##    Commands
##	  Folding
##    Visual editing
##    General rulebook
##    Indentation
##    Obscure and useful


#bc
scale=[num]
ibase=[num]
obase=[num]
quit

#Vim
##Navigation
      k
    h   l
      j

0  start of line
b  skip back one word
w  skip to next word
$  end of line

f{char}  forward to next {char} in line
F{char}  backward to prev {char} in line

gg  start of file
H   start of visible screen
M   middle of visible screen
L   end of visible screen
G   end of file

^o  goes to last cursor position
%   goes to matching bracked [{(<
^i  goes to next cursor position

^b  page up
^u  half a screen up
zL  half a screen right
^e  scroll down
zb  sets current line to bottom
zz  centers current line
zt  sets current line to top
^y  scroll up
zH  half a screen left
^d  half a screen down
^f  page down

[num]gt  switches to tab [num]
gt  goes forward one tab
^w^w  switches between active vim windows

##Insert and delete
    O
    I    ia    A
    o
O  insert: add line above
I  insert: start of line
i  insert: at cursor
a  insert: one right of cursor
A  insert: end of line
o  insert: add line below

d0  cut from cursor to start of line
dw  cut next word
D   cut from cursor to end of line

yy  copy line
y   copy selection
p   paste
dd  cut line

r  replace character
x  delete character
X  backspace
c{motion}  insert: deletes motion
s  cl
S  dd + O

u     undo
^r    redo
:^r:  redo last command

##Folding
zf  create fold from selection
zd  delete fold
zD  delete folds recursively

zM  close all folds
zC  close folds recursively
zc  close lowest selected fold
zo  open lowest selected fold
zO  open folds recursively
zR  open all folds

:mkview    save current folds
:loadview  load saved folds

##Commands
:w   write to file
:q   quit
:x   write (if changed) and quit
:q!  quit without saving

:[ | 2,6 | .,$ | %]s/old/new/[g, c, I]
	escape or special: + ? | & { ( )

:!cmd  runs /bin/bash/cmd

:tabe[dit] file  opens new tab for file
:tabclose      closes active tab
:tabonly[!]    closes all tabs, except active tab
:mksession n.vim  stores which tabs were opened

##Visual
v   visual: from cursor
V   visual: line selection
^v  visual: square block selection

aw  current word and space after it
iw  current word

i(  inside (..)
ib  inside block (..) [..] {..}

/query  ^f for query

N   previous match
gN  select previous match in visual
gn  select next match in visual
n   next match

gv  reselect previous selection

u  turns visual to lowercase
U  turns visual to lowercase
~  switches case of visual
U  turns visual to uppercase
g{case}{motion}  applies {case} to {motion}

:noh  disables highlighting until next search

## Buffers Windows and Tabs
set hidden
	Put that in your .vimrc to not go insane

Buffer
	An open file handle by vim. Active and
	hidden buffers are loaded in memory
:ls :buffers :files
	Lists all active, inactive and hidden buffers
:bnext :bprev :buffer $NAME :buffer$NUM
	Switches buffer
<C-O> || <C-I>
	Works inbetween buffers too! Jump to
	last active cursor spot
:e $PATH :edit $PATH
	Opens a new buffer for the file

Window
	Viewport into buffer. Windows are not
	tied to buffers and can switch independently
<C-W> s || <C-W> <C-S>
	Splits current window horizontally
:[N]new $PATH  :[N]sp[lit] $PATH
	Splits window horizontally and switches
	active window to the newly opened file.
	N is the window height. Default is half
<C-W> v || <C-W> <C-V>
	Splits current window vertically
:[N]vnew $PATH  :[N]vsp[lit] $PATH
	fsjlkfdsj
	Splits window vertically and switches
	active window to the newly opened file.
	N is the window width. Default is half
<C-W> c || <C-W> <C-C>
	Closes current window
<C-W> o
	Maximize active window
<C-W> T
	Move active window to its own tab
<C-W> h/j/k/l
	Navigate to different window
<C-W> H/J/K/L
	Move window
<C-W> +/-
	Increase/Decrease window height
<C-W> >/<
	Increase/Decrease window width
`N<C-W>_`
	Set window height to N
N<C-W> |
	Set window width to N
<C-W> =
	Set all windows to equalish size

Tabs
	Collections of windows. On startup
	pass `-p` to open a tab for each file
:tabnew $PATH
	Creates a new tab with one window
	for the active file
gt[N]
	Go one tab right. If $N is specified,
	got to tab number $N
gT
	Go one tab left

##General rulebook
~/.vimrc  see for startup commands

{num}{cmd}  *replays command num times*
    3yy

{cmd}!
    || Adds override to command
    || Toggles command

<SHIFT>  inverses effect or makes it more powerful

.  reapplies effect

##Indenting
2>>   idents current line twice
>2>  indents 2 lines, including the current
>%   indents lines including end and start of braces
>iB  indents lowest block contained in braces
]p   pastes content with indentation at cursor

##Obscure and useful
cw  deletes the next word and INSERT
cf{c}  deletes up to and including {c} INSERT
ct{c}  deletes up to {c} INSERT
c$  delets line and INSERT
o   opens new line below
zz  centers curr line on screen
cgn .  replaces next selections in the same way
J   combines next line with the current

## Reading material
https://learnvimscriptthehardway.stevelosh.com/

# Awk the programming language/utility
## Recipes
awk 'END { print NR;}'
	Counts the lines, for example in a file
awk '/^[0-9]{2}/ { print NR;}'
	Prints the line numbers of lines starting
	with 2 consecutive digits
awk 'match($0, /[0-9]{6}/) { print substr($0, RSTART, RLENGTH);}'
	Extracts the first 6-digit number from
	each line and prints it to stdout
