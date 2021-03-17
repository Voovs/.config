#Vim
Vim is a powerful modal text editor shipped with most Unix distributions. Your
MacOS and Linux system is very likely to already have it installed! This guide
will discuss how to use this program, though it may be more useful to use it as
reference documentation, while you get use to using Vim's own docs

## Introduction and Q & A
Who is Vim for?

While Vim's use cases are nearly endless, it's mostly used for editing code and
taking notes. It will particularly appeal to programmers looking to get off GUI
text editors and just do everything from a terminal. Vim has many great selling
points to be your non-GUI editor:
 - Doesn't rely on a mouse, only the keyboard
 - Absurdly configurable
 - Really fast
 - Great help documentation
 - Shipped with most Unix systems, so you can often use it on others' devices
 - Immense community backing

Strangely Vim also happens to be one of the best solutions to taking typed
notes, once configured correctly. This mostly comes don't to not needing a mouse
and really easy key bindings. If you're interested in that, you'll want to look
at plugins such as `Vimwiki` right away

Is it faster?

Yes.

Although it'll vary based on the person, using Vim will generally make you so
much faster, when you already know what you're doing. Especially for anyone
constantly in command like, a non-GUI Vim makes you feel like you're typing
faster than you're thinking, which feels really nice

How's the transition?

Transitioning to Vim, when you've only ever used IDE style text editors isn't a
quick process. It'll take 1-2 weeks of daily usage to regain you IDE developing
speed. However, after a month, you'll end up much faster than what the IDE can
manage across all fronts

If you're considering a Vim transition, make sure you have a week or two where
you don't need to type at top speeds. It'll take more than a week if you're
still using your IDE editor for faster coding

With that considered. You'll know if Vim is the text editor for you. If you're
still unsure, just give it a shot in your spare time and maybe you'll really
like it!

Disclaimer: Vim will not become your IDE no matter now much you configure it. It
shouldn't be. Things like multiple cursor editing and file tree navigation are
done differently in Vim. One of the most common mistakes beginners make is
trying to make Vim act identical to their IDE, instead of learning Vim's way of
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

*Exiting Vim!!!*
    :q
As one of the most asked questions about Vim of all time, exiting Vim is not
that difficult. Just type `:q` from command mode and Vim will quit. If you have
written some text and don't want to save it, *just get me out of here!!!*, use
`:q!` instead

    :w
If you want to save the edits you made to a file, you'll type `:w` to write to
that file. Vim overwrites the current file with its own edited copy, which is
where the name comes from. It's the equivalent of an IDE `ctrl + s`

    :x
Write to the file, there there were any changes, then quit Vim. A great shortcut
for when you're quickly editing one file

    :help
Type `:help` followed by a topic to open the Vim help docs on that topic! Super
useful for both beginners and pros, though you may want to consider googling for
help if you don't know what to search for yet

## Motion
Motion is core to Vim. You'll be using it to navigate around your code and
executing commands on that code. In general, you can put any motion in from of
any motion-operator command. These will become clear shortly. You can also put a
number `N` before any motion to multiply that motion `N` times

Since motions are used so frequently, most Vim configurations remap these to the
user's liking. When starting to remap keys, begin with motion operators, since
you'll find they speed a lot!

      k
    h   l
      j
These 4 keys are core to Vim. Think of them like arrow keys, since that's what
they're going to replace. You should almost NEVER use the arrow keys in Vim. In
fact it's suggested that Vim beginners disable the arrow keys in Vim

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

    )  move by sentences
    }  move by paragraphs
    ]]  move to next } in the first column
Inter-line movements. Not too useful in code, though nice for prose texts

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

    iw  Current word. "inner word"
    aw  Current word and following space. "a word"
    is  Current sentence
    ap  Current paragraph, notably bound by a blank line
Several handy motions. `a` and `i` are interchangeable, just `a` also includes
the ending delimiter

    i( || i{ || i[ || i< || i" || i' || i`
Inside specified delimiter. `a` can replace `i` to include the delimiters

    ib
    iB
Inner block. `b` picks up `()` as delimiters and `B` uses `{}`

#### Querying
You can do a ^f like query in Vim. In fact it's much more powerful
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

See [the marks section](#Marks) for a great optimization
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
Vim starts in "normal" mode. As you use Vim, you'll see why insert mode is often
too limited in its functionality, though of course you'll still be using it all
the time

*Exiting insert mode*
Before moving on, it's really important to know how to get out of insert mode
and back to normal mode. By default, Vim maps `<ESC>` and `<C-[>` as ways to
escape insert mode, except both of these really really suck. The one and only
configuration someone who's never used Vim must do is remap this escape key.
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
Vim's clipboard in the unnamed register `"` which you can view with `:echo @"`

The `N` can be any number and will multiply the motion that many times

    yy
Copies current line. Very useful when used like `2yy` to grab several lines
    p
Paste from Vim's clipboard. Keep in mind this only works in normal mode! Remap
some key bindings to avoid this restriction:
    inoremap <C-p> <ESC>pi

    ]p
Pastes content of clipboard at current indentation level

#### Deleting
Anything you delete will automatically be copied. Keep this in mind, since
this can overwrite Vim's clipboard! To access the backup clipboard use register
0

    d{motion}
While you can use backspace from insert mode to delete characters, that's really
inefficient and slow for anything beyond a few characters. The `d` operator is
used much like the `y` operator, except for deletion. Keep in mind that `d` will
also copy the text it deletes, which overwrites Vim's clipboard
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
To make make sure you can delete with confidence, Vim has a very effective
undo/redo system
    u
Undo the last action. Like `ctrl + z` except easier to hit and actually works in
Vim
    <C-r>
Redo next action. Helpful for checking what change you just made with `u`

You should also note that Vim doesn't automatically save things. If you really
messed up a file, just exit with `:q!` or `:bd!` which won't save any changes
done to the file. If all else fails, `git checkout <file>`, though that's a
really rare situation

## Visual mode
Visual mode is very powerful for letting you see the motion operation. While
almost everything from visual mode can be done via motions, visual mode allows
for a greater degree of control, particularly when making very large motions
    v
The first visual mode is just called visual. It acts exactly like a mouse
selecting text. Of course you can move with the usual Vim motion keys
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
Buffers are open files in Vim. You can think of them like browser tabs.
They're always there, though you may not be able to see the content of all
the tabs at once. Like some browsers, Vim doesn't tie down buffers to any one
specific window, meaning you can open the same buffer in different windows
    set hidden
Put that in your .Vimrc to not go insane
    :ls :buffers :files
Lists all active, inactive and hidden buffers
    :bnext :bprev :buffer $NAME :buffer$NUM
Switches buffer
    <C-O> || <C-I>
Commands to jump to old/next cursor positions. If the old/next cursor position
is is another buffer, Vim will switch buffers
    :e $PATH :edit $PATH
Opens a new buffer for the file. Since this is incredibly slow and common, check
out the fzf plugin to make this ridiculously fast

#### Windows
Windows can roughly be thought of as browser windows. You can change tabs and
sites all you want, though the browser window doesn't move. Vim windows are a
set space providing a viewport into a buffer. Much like switching browser
tabs, Vim windows aren't tied to any one specific buffer
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

    $ Vim ~/.Vimrc
On startup, Vim will read `~/.Vimrc` for commands to run. These include

### Repetition of actions
As you have already seen, custom key bindings are one of the best ways to make
repetitive actions quick. Scripting up some functions and linking them to a key
bind is even better. However, both these methods require preparation. Here we'll
look at one-time repeats you can write mid-programming

### Registers
Registers are Vim's internal temporary storage. Copy, pasting, deletion and
other operators that rely on a global state will often use a register to store
their data. Scripts and key maps can take advantage of these too

In general, many operators that rely on registers such as `y`, `d`, and `p`
accept a register as an argument ahead of them like `"0p`. Repitition goes in
front of the register, like `3"0p`. You can think of default `p` as `1""p`

See `:h registers` for more information

    :reg || :dis
Lists all the active registers and their contents

    ""
The unnamed register mirrors the last write to any other register, except the
void register `"_`. It's also the default register for many operators

    "0
The yank register. This is the official register `y` writes to, though its
mirror `""` is often used. Writing directly to `""` also writes to `"0`

    "_
The void register. Vim's equivalent of /dev/null. When something is
yanked/deleted here, a copy won't be stored in `""`

    ".  Last inserted text. Read only
    ":  Last executed command. Read only
    "%  The path to the current file. Read only
    "-  Deletes that are less than one line
    "*  The true system clipboard (if accessible)
    "+  "Primary" system clipboard. Doesn't work with vanilla vim on MacOS
    "/  Last search query
Some useful Vim-assigned registers

    "a
    "z
All the registers in between are user or plugin assigned. Reading from these
registers is case insensitive. However, writing to an uppercase register will
append to the register, while lowercase will replace

    :let @+ = @%
You can write to and between registers using this syntax. This shows a case
where Vim will copy the entire file's contents onto the system clipboard

    <C-r>0
Incredibly useful way to call registers from insert mode. Particularly for
pasting! `0` here can be replaced with any other register's name too

    @a
Execute the register, in this case register `"a`. See [the macros
section](#Macros) to see this in action

    @:
Handy macro to rerun last command prompt command. Remember that `":` stores the
keys sent in the last command prompt execution

#### Macros
When you need to repeat actions, Vim's simple key mapping system is a great
solution. However, there are time when you just need to repeat an action 10
times once. In these cases we can use mapping, except not bother binding it to a
key. Vim calls these "macros"

See `:h complex-repeat` for more

    q{char}{cmd}q
Order of recording a macro. `{char}` is any letter and `{cmd}` is any sequence
of actions, except recording another macro. You'll notice that while recording a
macro, your actions actually take place, which makes it easier to guarantee your
macro works as expected

Here's the hidden magic: All this does is throw all the keys you typed into
register `"{char}`! See it for yourself! You can even paste the macro you
recorded with `"{char}p`. You might start seeing the power behind this

    [N]@{char}
Replays macro `{char}` `N` times. This is simply executing the register with the
macros' name

    @@
Replays the last played macro

    :let @w = '^rw
Easily edits the current macro. In this case it'll paste the contents of the
`"w` register. Don't actually type `^r`, hit <C-r> instead. Make sure you close
the string with a `'` at the end

Tip: Instead of trying to figure out a complex key mapping, run it as a macro
then paste the contents of the recorded register (`<C-r>a`) as the key bind

### Marks
Tired of scrolling? Well you should be, since Vim's decent scrolling mechanism
will start to feel incredibly inefficient after a while. Marks solve this by
allowing you to easily jumped between "marked" points

    m{char}
Sets a mark named `{char}`. You can have one of each lowercase letter per
buffer, though only one uppercase of each mark per vim session. This allows
uppercase marks to be used for buffer switching

    '{char}
    `{char}
Jumps to the mark. This is considered a motion, unless you switch buffers. `'`
moves your cursor to the start of the mark's line, while the backtick moves to
the exact spot the mark was left at. The two are often reversely remapped

    :marks
List all marks in the current vim session

    :delm a
Deletes a mark, in this case `a`. If no arguments are provided, all lowercase
marks for the current buffer are deleted

Marks are key in many Vim scripts. Here are some special marks:
    `<  First character of current visual selection
    `>  Last character of current visual selection
    ``  Character before the latest jump used for <C-o>


    <C-o>
Move to old/previous cursor position. Uses the \`\` mark
    <C-i>
Move to next cursor position


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
mostly useful for Vim-scripting. I'd recommend suspending Vim and just running
the command in terminal instead. Tends to do better with output

    :[mode]noremap [input] [output]
    :nnoremap <C-k> <ESC>
Map key bindings! These should go in your `~/.Vimrc`, though you can make
temporary bindings while in Vim too

## Reading material
If you're interested in learning even more about Vim, check out these readings
    ~/.Vimrc
If you're accessing this in the /notes directory off a git branch in my
configuration files, look around for the Vim directory which could give you a
good idea of how to write a startup file. Otherwise, just checkout some .Vimrc
online, just as jonhoo's
    https://learnVimscriptthehardway.stevelosh.com/
Learn Vimscript
    https://tdaly.co.uk/projects/Vim-statusline-generator/
Make your own status bar
    https://github.com/Vimwiki/Vimwiki/blob/master/README.md
Really extensive Vim plugin for note taking