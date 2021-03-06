#Vim
Vim is a powerful modal text editor shipped with most Unix distributions. Your
MacOS and Linux system is very likely to already have it installed! This guide
will discuss how to use this program, though it may be more useful to use it as
reference documentation, while you get use to using vim's own docs

## Introduction and Q & A
Who is vim for?

While vim's use cases are nearly endless, it's mostly used for editing code and
taking notes. It will particularly appeal to programmers looking to get off GUI
text editors and just do everything from a terminal. Vim has many great selling
points to be your non-GUI editor:
 - Doesn't rely on a mouse, only the keyboard
 - Absurdly configurable
 - Really fast
 - Great help documentation
 - Shipped with most Unix systems, so you can often use it on others' devices
 - Immense community backing

Strangely vim also happens to be one of the best solutions to taking typed
notes, once configured correctly. This mostly comes don't to not needing a mouse
and really easy key bindings. If you're interested in that, you'll want to look
at plugins such as `vimwiki` right away

Is it faster?

Yes. 

Although it'll vary based on the person, using vim will generally make you so
much faster, when you already know what you're doing. Especially for anyone
constantly in command like, a non-GUI vim makes you feel like you're typing
faster than you're thinking, which feels really nice

How's the transition?

Transitioning to vim, when you've only ever used IDE style text editors isn't a
quick process. It'll take 1-2 weeks of daily usage to regain you IDE developing
speed. However, after a month, you'll end up much faster than what the IDE can
manage across all fronts

If you're considering a vim transition, make sure you have a week or two where
you don't need to type at top speeds. It'll take more than a week if you're
still using your IDE editor for faster coding

With that considered. You'll know if vim is the text editor for you. If you're
still unsure, just give it a shot in your spare time and maybe you'll really
like it!

Disclaimer: Vim will not become your IDE no matter now much you configure it. It
shouldn't be. Things like multiple cursor editing and file tree navigation are
done differently in vim. One of the most common mistakes beginners make is
trying to make vim act identical to their IDE, instead of learning vim's way of
doing things. Vim's way, while initially seeming worse and nonsensical, will
gradual grown on you until you find it much faster and more intuitive

## Commands
Vim has a command prompt. This is quite unlike most IDE text editors, in that
it's ridiculously more powerful. You can usually do anything you could do from
normal mode in the command prompt

This article will usually be referring to normal mode command, which you simply
hit on your keyboard with no prefix. To run any command prompt command, you'll
first have to open command prompt from normal mode with `:`, so I'll prefix any
command prompt stuff with `:`

*Exiting vim!!!*
    :q
As one of the most asked questions about vim of all time, exiting vim is not
that difficult. Just type `:q` from command mode and vim will quit. If you have
written some text and don't want to save it, *just get me out of here!!!*, use
`:q!` instead

    :w
If you want to save the edits you made to a file, you'll type `:w` to write to
that file. Vim overwrites the current file with its own edited copy, which is
where the name comes from. It's the equivalent of an IDE `ctrl + s`

    :x
Write to the file, there there were any changes, then quit vim. A great shortcut
for when you're quickly editing one file
    
    :help help
Type `:help` followed by a topic to open the vim help docs on that topic! Super
useful for both beginners and pros, though you may want to consider googling for
help if you don't know what to search for yet

## Motion
Motion is core to vim. You'll be using it to navigate around your code and
executing commands on that code. In general, you can put any motion in from of
any motion-operator command. These will become clear shortly. You can also put a
number `N` before any motion to multiply that motion `N` times

Since motions are used so frequently, most vim configurations remap these to the
user's liking. When starting to remap keys, begin with motion operators, since
you'll find they speed a lot!

      k
    h   l
      j
These 4 keys are core to vim. Think of them like arrow keys, since that's what
they're going to replace. You should almost NEVER use the arrow keys in vim. In
fact it's suggested that vim beginners disable the arrow keys in vim

    0  move start of line
    b  move back one word
    F{char}  move backwards to the previous instance of {char} in this line
    t{char}  move forward to right before next instance of {char} in this line
    f{char}  move forward to the next instance of {char} in this line
    e  move to end of word
    w  move to next word
    $  move end of line
Here are some very convenient motions within a line. You'll find these are some
of the most frequently used motions for commands

    gg  start of file
    H   start of visible screen
    M   middle of visible screen
    L   end of visible screen
    G   end of file
These motions navigate the entire file. `H`,`M`, and `L` are often not
considered all that useful, as you can emulate them with `Nj` or `Nk` where `N`
is a number

#### Even move motions
    %
Move to matching delimiter (`({[<>]})`). You can usually use `i(` and such for a
more useful effect
    aw  
Current word and space after it
    iw
Current word. "inner word"
    i( || i{ || i[ || i<
Inside specified delimiter
    ib
Inside block. Should pick up first delimiter it finds from the motions above
    <C-o>
Move to old/previous cursor position
    <C-i>
Move to next cursor position

#### Querying
You can do a ^f like query in vim. In fact it's much more powerful
    /foobar
Searches can also be used as motion operators! Very useful for deleting parts of
a prose line

    \/cFooBar
`\c` will remove case sensitivity

    \v  very magic
    \V  very nomagic
Much like `\c` these modify the search scope, in this case enabling/disabling
regular expressions. `\V` is the most familiar, requiring escape sequences for
all special characters

    N  move to previous match
    gN  visually select previous match
    gn  visually select next match
    n  move to next match
`N` and `n` work great as motion operators, while `cgN` + `.` is one of the most
popular multi-cursor simulators. It's so good, you'll like it more than the IDE
approach

### Scrolling and viewport adjustment
We have all the ways to move around our cursor, though we can also move around
the entire page! Pair them with [visual mode](#Visual-mode) if you'd like to use
them as motion operators, which is really helpful for big operating areas

    <C-b>  Scroll [back] up an entire page
    <C-u>  Scroll up half a page
    <C-y>  Scroll one line up
    <C-e>  Scroll one line down
    <C-d>  Scroll down half a page
    <C-f>  Scroll [forward] down an entire page
These are super common to use instead of a mouse. I personally prefer half page
scrolling to full page scrolling almost always, as it's much less jarring

    zt  Sets current to the top of the window
    zz  Centers current line in window
    zb  Sets current to the bottom of the window
Indispensable for getting the screen right. Scrolling is often too tedious, so
these are great quick ways for adjusting the window. I use `zz` so much it's a
common spelling mistake in google docs for me

    zL  Scrolls half a screen right
    zH  Scrolls half a screen left
Sometimes helpful for very long lines, though you may prefer automatic line
wrapping `set wrap linebreak` paired with &textwidth for prose

#### Folding
Vim supports many types of folding, though you'll almost always stick with
manual folding. Folding is generally controlled by `z`

    zf  create fold from selection
    zd  delete fold
    zD  delete folds recursively
Creating and deleting fold


    zM  close all folds
    zC  close folds recursively
    zc  close lowest selected fold
    zo  open lowest selected fold
    zO  open folds recursively
    zR  open all folds
Opening and closing folds

#### Indents
    >>
    <<
Indent or unindent the current line by one `&tabstop`. To indent lines multiple
times, use this operator in visual line mode and a number `N>>`

## Insert mode, Replace mode, and deletion commands
#### Insert mode
Insert mode is the default mode for almost every other text processor. Only
vim starts in "normal" mode. As you use vim, you'll see why insert mode is often
too limited in its functionality, though of course you'll still be using it all
the time

*Exiting insert mode*
Before moving on, it's really important to know how to get out of insert mode
and back to normal mode. By default, vim maps `<ESC>` and `<C-[>` as ways to
escape insert mode, except both of these really really suck. The one and only
configuration someone who's never used vim must do is remap this escape key.
Consider looking online for some idea on how to do this, though the one I use
looks something like:
    inoremap <C-k> <ESC>
    nnoremap <C-k> <ESC>
    vnoremap <C-k> <ESC>
    cnoremap <C-k> <C-c>
These work for me since I remapped my capslock key to control in my operating
system settings. You'll also want more mapping than these too, though they
should be fine for beginning

    O  open line above
    I    ia    A
    o  open line below
These basic keys will move to a position and put you in insert mode. Usually `i`
is used for starting off. `O` and `o` will insert a new line above/below, making
them a great alternative to `<Enter>`

    R
Replace mode is very similar to insert mode, though it doesn't shift surround
text positions. Sometimes useful to preserve code alignments
    r{char}
Replace mode though only for a single character. Much more useful than full
blown replace mode
    s
Delete next character and go into insert mode
    S
Delete current line and go into insert mode

#### Copying
Vim has an internal clipboard which will no conflict with you system clipboard.
If you want to paste something from your clipboard, use `ctrl/cmd + v` from
inside insert mode instead
    [N]y{motion}
Copy text up using the motion. Refer to the [motions section](#Motion) for which
motions you can use. This is also compatible with visual mode. You can access
vim's clipboard in the unnamed register `"` which you can view with `:echo @"`

The `N` can be any number and will multiply the motion that many times

    yy
Copies current line. Very useful when used like `2yy` to grab several lines
    p
Paste from vim's clipboard. Keep in mind this only works in normal mode! Remap
some key bindings to avoid this restriction:
    inoremap <C-p> <ESC>pi

    ]p
Pastes content of clipboard at current indentation level

#### Deleting
Anything you delete will automatically be copied. Keep this in mind, since
this can overwrite vim's clipboard!

    d{motion}
While you can use backspace from insert mode to delete characters, that's really
inefficient and slow for anything beyond a few characters. The `d` operator is
used much like the `y` operator, except for deletion. Keep in mind that `d` will
also copy the text it deletes, which overwrites vim's clipboard
    d0  Delete to start of line
    dw  Delete the next word
Some examples of common operator usage
    x 
Deletes the next character. Identical to `dl`. `X` is similar though more
familiar, as it looks like backspace
    D
Deletes from the cursor to the end of the line. Identical to `d$`
    dd
Delete current line. Incredibly useful when paired with visual line mode and
multiplying, such as `4dd`

#### Undo and Redo
To make make sure you can delete with confidence, vim has a very effective
undo/redo system
    u
Undo the last action. Like `ctrl + z` except easier to hit and actually works in
vim
    <C-r>
Redo next action. Helpful for checking what change you just made with `u`

You should also note that vim doesn't automatically save things. If you really
messed up a file, just exit with `:q!` or `:bd!` which won't save any changes
done to the file. If all else fails, `git checkout <file>`, though that's a
really rare situation

## Visual mode
Visual mode is very powerful for letting you see the motion operation. While
almost everything from visual mode can be done via motions, visual mode allows
for a greater degree of control, particularly when making very large motions
    v
The first visual mode is just called visual. It acts exactly like a mouse
selecting text. Of course you can move with the usual vim motion keys
    V
Selects entire lines. You'll probably be using this one the most for code
    <C-v>
Block visual mode is quite unique. It's a grid-like selection that completely
ignores line breaks. While not immediately helpful, it's actually necessary for
cursor multiplying, similar to what many IDE offer
    gv
Reselect previous selection
    gq
Line break selected lines around the character count set by &textwidth. I've
used this one constantly for writing markdown notes

#### More with visual
    u  turns casing to lowercase
    U  turns casing to lowercase
    ~  inverts casing of selection
    U  turns casing to uppercase
    g{case}{motion}  applies {case} to {motion}

    :noh
Disables search highlighting until next search

## Vim's display system
#### Buffers
Buffers are open files in vim. You can think of them like browser tabs.
They're always there, though you may not be able to see the content of all
the tabs at once. Like some browsers, vim doesn't tie down buffers to any one
specific window, meaning you can open the same buffer in different windows
    set hidden
Put that in your .vimrc to not go insane
    :ls :buffers :files
Lists all active, inactive and hidden buffers
    :bnext :bprev :buffer $NAME :buffer$NUM
Switches buffer
    <C-O> || <C-I>
Commands to jump to old/next cursor positions. If the old/next cursor position
is is another buffer, vim will switch buffers
    :e $PATH :edit $PATH
Opens a new buffer for the file. Since this is incredibly slow and common, check
out the fzf plugin to make this ridiculously fast

#### Windows
Windows can roughly be thought of as browser windows. You can change tabs and
sites all you want, though the browser window doesn't move. Vim windows are a
set space providing a viewport into a buffer. Much like switching browser
tabs, vim windows aren't tied to any one specific buffer
    <C-W> s || <C-W> <C-S>
Splits current window horizontally
    :[N]new $PATH  :[N]sp[lit] $PATH
Splits window horizontally and switches active window to the newly opened file.
N is the window height. Default is half
    <C-W> v || <C-W> <C-V>
Splits current window vertically
    :[N]vnew $PATH  :[N]vsp[lit] $PATH
Splits window vertically and switches active window to the newly opened file.
`N` is the window width. Default is half
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
    N<C-W>_
Set window height to `N`
    N<C-W> |
Set window width to `N`
    <C-W> =
Set all windows to equal-ish size

#### Tabs
"Tabs" are a collection of windows. You can think of them like virtual desktops.
On startup pass `-p` to open a tab for each file
    :tabnew $PATH
Creates a new tab with one window for the active file
    gt[N]
Go one tab right. If $N is specified, got to tab number $N
    gT
Go one tab left

## Other useful tips
    :set number relativenumber
Gives very nice line numbering, for executing motion commands

    $ vim ~/.vimrc
On startup, vim will read `~/.vimrc` for commands to run. These include
#### Spelling
    :setlocal spell spelllang=en_us
Enable spellchecking for the local buffer. You probably don't want to enable it
for all buffers, if you're also coding
    ]s [s
Move cursor to next/prev spelling error
    z=
See all spelling suggestions for word under cursor
    zg
Mark word as all good. Vim will add it to its local dictionary
    zw
Mark word as incorrectly spelled. Vim will add it to its anti-dictionary

## More commands
Having covered all of basic normal mode, it's time to look at command prompt
again, this time with more command-like commands
    :[2,6 | .,$ | %]s/old/new/[g]
    :[scope]s/<search>/[replace]/[g]
    :%s/foo/bar/g
Search and replace. You can specify the scope, or it'll default to only the
current line. `[search]` works very much like querying with `/`, accepting
regular expressions as well. `/g` at the end makes sure it doesn't just replace
the first occurrence on every line

    :!{shell command}
    :!ls .
Vim allows you to run shell commands right from the command prompt! This is
mostly useful for vim-scripting. I'd recommend suspending vim and just running
the command in terminal instead. Tends to do better with output

    :[mode]noremap [input] [output]
    :nnoremap <C-k> <ESC>
Map keybindings! These should go in your `~/.vimrc`, though you can make
temporary bindings while in vim too

## Reading material
If you're interested in learning even more about vim, check out these readings
    ~/.vimrc
If you're accessing this in the /notes directory off a git branch in my
configuration files, look around for the vim directory which could give you a
good idea of how to write a startup file. Otherwise, just checkout some .vimrc
online, just as jonhoo's
    https://learnvimscriptthehardway.stevelosh.com/
Learn vimscript
    https://tdaly.co.uk/projects/vim-statusline-generator/
Make your own status bar
    https://github.com/vimwiki/vimwiki/blob/master/README.md
Really extensive vim plugin for note taking

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
