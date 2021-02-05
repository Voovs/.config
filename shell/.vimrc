" ========================================================
" # GUI settings
" ========================================================
" Relative numbering, except for current line
set number relativenumber

" Scroll before hitting edge
set scrolloff=2

"Interactive mouse
set mouse=a
map <ScrollWheelUp> <C-Y>
map <ScrollWheelUp> <C-E> 

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

" ========================================================
" # Keyboard shortcuts
" ========================================================
" ; as : for commands
nnoremap ; :

" Space as leader
let mapleader = "\<Space>"

" Open hotkeys
nnoremap <C-p> :files<CR>
nnoremap <leader>; :buffers<CR>

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

" Window control with leader
nnoremap <leader>w <C-w>

    " Quick window switching
nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l

    " Window resizing
nnoremap <leader>, 10<C-w><
nnoremap <leader>. 10<C-w>>
nnoremap <leader>< 10<C-w>+
nnoremap <leader>> 10<C-w>-

" Open .vimrc for quick editing
nnoremap <leader>vim :vsplit ~/.vimrc<CR><C-w>H
nnoremap <leader>vims :source ~/.vimrc<CR>:x<CR>

" Case insensitive search
nnoremap <leader>/ /\c

" Uppercase previous word from Insert mode
inoremap <C-u> <ESC>vbU`>a

set whichwrap+=>,l " wraps up a line on right key
set whichwrap+=<,h " wraps up a line on left key

set backspace=eol,start,indent

let $BASH_ENV = "~/.bash_aliases"


filetype plugin indent on " Vim's auto-indenting is broken without this

" Tabs to spaces
set tabstop=4       " number of spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4    " number of spaces to use for autoindent
set expandtab       " tabs are space
set autoindent
set copyindent      " copy indent from the previous line

if has('gui_running')
	set nowrap
endif

" ========================================================
" Text visuals
" ========================================================
" Syntax and search highlighting
syntax enable
set hlsearch

set guifont=Menlo\ Regular:h16

" Syntax theme
set background="dark"
let base16colorspace=256
colorscheme base16-gruvbox-dark-pale
syntax on
set termguicolors

" ========================================================
" Language specific
" ========================================================
autocmd Filetype rust set colorcolumn=100 
autocmd Filetype markdown set wrap
autocmd Filetype markdown set spell

au Filetype python iabbrev #! #!/usr/local/bin/python3

" Motion to construct name
augroup function_name
    " function and class names
    au Filetype python onoremap ih :execute ":normal! ?def [A-z]\\+(\\\|class [A-Z][A-z]*\\(:\\\|(\\)\r:noh\rwve"<CR>
    " fn, struct, and enum names
    au Filetype rust onoremap ih :execute ":normal! ?fn [a-z]\\+\\\|\\(struct\\\|enum\\) [A-Z]\r:noh\rwve"<CR>
augroup END

" ========================================================
" Experimental
" ========================================================

"Utilities
" Allow buffers to be hidden
set hidden

" Spelling substitutions
iabbrev em —
iabbrev @@ vselin12@gmail.com

" Save folds when closing buffer
" NOTE: Very buggy. Don't rely on it, especially with macvim
augroup remember_folds
	autocmd!
	autocmd BufWinLeave + mkview
	autocmd BufWinEnter + silent! loadview
augroup END

" Clear search entirely
" let @/ = ""

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
