" ========================================================
" # GUI settings
" ====================================================={{{
" Relative numbering, except for current line
set number relativenumber

" Scroll before hitting edge
set scrolloff=2

"Interactive mouse
set mouse=a
map <ScrollWheelUp> <C-Y>
map <ScrollWheelDown> <C-E>

" Fast bracket matches
set showmatch
set matchtime=0 " Set to 0 for no latency

" More natural window splitting
set splitbelow
set splitright

" Tail of active buffer
set guitablabel=%t " Does not work for airline
" set guitablabel=%t

" 80 char marker
set colorcolumn=80

" Only run in vanilla vim
if !has('nvim') && !has('gui_running')
    " Highlight active line in normal mode
    au InsertEnter,InsertLeave * set cul!
    set cursorline

    " Line cursor in insert mode
    " Might not work in some terminals. Might also trap your cursor in block,
    " even after exiting vim
    let &t_SI = "\e[6 q"
    let &t_EI = "\e[2 q"
endif
" }}}

" ========================================================
" # Keyboard shortcuts
" ====================================================={{{
" ; as : for commands
nnoremap ; :

" Space as leader
let mapleader = "\<Space>"

" Ctrl+k as Esc
nnoremap <C-k> <ESC>
inoremap <C-k> <ESC>
vnoremap <C-k> <ESC>
snoremap <C-k> <ESC>
xnoremap <C-k> <ESC>
cnoremap <C-k> <C-c>
onoremap <C-k> <ESC>
lnoremap <C-k> <ESC>
tnoremap <C-k> <ESC>

" Suspend with Ctrl+f
inoremap <C-f> :sus<CR>
vnoremap <C-f> :sus<CR>
nnoremap <C-f> :sus<CR>

" Jump to line start/end using homerow
noremap H ^
noremap L $

" Move by lines
nnoremap j gj
nnoremap k gk

" Bash-like jump to start
cnoremap <C-a> <C-b>

" Switch buffers with ,h/l
nnoremap ,h :bnext<CR>
nnoremap ,l :bnext<CR>
" nnoremap ,

" Window control with leader
nnoremap <leader>w <C-w>

    " Quick window switching
nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l

    " Window movement
nnoremap <leader><leader>h <C-w>H
nnoremap <leader><leader>j <C-w>J
nnoremap <leader><leader>k <C-w>K
nnoremap <leader><leader>l <C-w>L

    " Window resizing
    " < increases, > decreases
nnoremap <leader>, 10<C-w>>
nnoremap <leader>. 10<C-w><
nnoremap <leader><leader>, 10<C-w>+
nnoremap <leader><leader>. 10<C-w>-

" Case insensitive search
nnoremap <leader>/ /\c

" Uppercase previous word from Insert mode
inoremap <C-u> <ESC>vbU`>a

" }}}

" ========================================================
" Text visuals
" ====================================================={{{
" Syntax and search highlighting
syntax enable
set hlsearch incsearch

set guifont=Menlo\ Regular:h16

" Syntax theme
set background="dark"
let base16colorspace=256
colorscheme base16-gruvbox-dark-pale " From base16 vim repo
syntax on
set termguicolors " Actual colors

" }}}

" ========================================================
" Language specific
" ====================================================={{{
autocmd Filetype rust set colorcolumn=100
autocmd Filetype markdown set wrap
autocmd Filetype markdown set linebreak " Wrap on words
autocmd Filetype markdown set spell " Noticable slowdown

au Filetype python iabbrev <buffer> #! #!/usr/local/bin/python3
" Bug fix for python interpreter seeing #!.../python3^M
au Filetype python set fileformat=unix

" Motion to construct name
augroup function_name
    " function and class names
    au Filetype python onoremap ih :execute ":normal! ?def [A-z]\\+(\\\|class [A-Z][A-z]*\\(:\\\|(\\)\r:noh\rwve"<CR>
    "au Filetype python onoremap ih :execute ':normal! ?def [A-z]\+(\|class [A-Z][A-z]*\(:\|(\)' . "\r" . ":noh\rwve"<CR>
    " fn, struct, and enum names
    au Filetype rust onoremap ih :execute ":normal! ?fn [a-z]\\+\\\|\\(struct\\\|enum\\) [A-Z]\r:noh\rwve"<CR>
    "au Filetype vim onoremap ih :execute ":normal! ?function [a-z]!?\\+\r:noh\rwve"<CR>
augroup END

" }}}

" ========================================================
" Experimental
" ========================================================{{{

"Utilities
" Allow buffers to be hidden
set hidden

" Spelling substitutions
iabbrev em —
iabbrev @@! vselin12@gmail.com

" Save folds when closing buffer
" NOTE: Very buggy. Don't rely on it, especially with macvim
augroup remember_folds
    autocmd!
    autocmd BufWinLeave + mkview
    autocmd BufWinEnter + silent! loadview
augroup END

" Clear search entirely
" let @/ = ""

"TODO: Maybe setup matching?
"nnoremap <leader>g :execute "match Todo /" . expand("<cWORD>") . "/"<cr>
" From Jonhoo, sets ripgrep as grep
if executable('rg')
    set grepprg=rg\ --no-heading\ --vimgrep
    set grepformat=%f:%l:%c:%m
endif
" Convenience grepping
nnoremap <leader>gn :execute ":normal! :cnext\r"<CR>
nnoremap <leader>gN :execute ":normal! :cprevious\r"<CR>

set backspace=eol,start,indent " ???

" Use aliases for shell commands. Kinda unnecessary
let $BASH_ENV = "~/.bash_aliases"


" Autocompletion for wrappers
" inoremap " ""<left>
" inoremap ' ''<left>
" inoremap ( ()<left>
" inoremap [ []<left>
" inoremap { {}<left>
" inoremap < <><left>
" inoremap {<CR> {<CR>}<ESC>O
" inoremap {;<CR> {<CR>};<ESC>O

" murphy - really dark and softer letters. Good true darkmode
" darkblue - normalish just darker background. Mixed color results
" torte - darkblue with brighter greys. Nice soft colors
" shine - citrus equivelent for vim. Nice for lightmode
" peachpuff - autumn colors. Maybe useable in a light terminal
" base16-tomorrow-night - my classic atom dark theme

" }}}

" ========================================================
" Global configs (unlikely to change)
" ========================================================{{{
" Tidy vimrc with folds
augroup vimrc_folds
    " Mark folds with {{{
    au Filetype vim setlocal foldmethod=marker
    " Open .vim files folded
    au Filetype vim,BufReadPre setlocal foldlevelstart=0
augroup END

" Open .vimrc for quick editing
command! Vim :normal! :vsplit ~/.vimrc<CR><C-w>H
command! Vims :normal! :w<CR>:source ~/.vimrc<CR>:x<CR>

" A place to quickly take a note
command! Note :split ~/.vim/vim_notepad.md

" Wrap horizontal line movement
set whichwrap+=>,l " end of line above on h
set whichwrap+=<,h " start of line below on l

" Tabs to spaces
set tabstop=4       " number of spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4    " number of spaces to use for autoindent
set expandtab       " tabs are space
set autoindent
set copyindent      " copy indent from the previous line

" Vim's auto-indenting is broken without this
filetype plugin indent on

" }}}
