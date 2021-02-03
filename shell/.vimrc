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

" set showmatch " Enabling this lags Neovim hard

" More natural window splitting
set splitbelow
set splitright

" Tail of active buffer
set guitablabel=%t " Does not work for airline

" 80 char marker
set colorcolumn=80

" ========================================================
" # Keyboard shortcuts
" ========================================================
" ; as : for commands
nnoremap ; :

" Ctrl+j and Ctrl+c as Esc
nnoremap <C-j> <ESC>
inoremap <C-j> <ESC>
vnoremap <C-j> <ESC>
snoremap <C-j> <ESC>
xnoremap <C-j> <ESC>
cnoremap <C-j> <ESC>
onoremap <C-j> <ESC>
lnoremap <C-j> <ESC>
tnoremap <C-j> <ESC>
inoremap <C-c> <ESC>

nnoremap <C-k> <ESC>
inoremap <C-k> <ESC>
vnoremap <C-k> <ESC>
snoremap <C-k> <ESC>
xnoremap <C-k> <ESC>
cnoremap <C-k> <ESC>
onoremap <C-k> <ESC>
lnoremap <C-k> <ESC>
tnoremap <C-k> <ESC>

" Suspend with Ctrl+f
inoremap <C-f> :sus<cr>
vnoremap <C-f> :sus<cr>
nnoremap <C-f> :sus<cr>
 
" Move by lines
nnoremap j gj
nnoremap k gk

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
" Experimental
" ========================================================

"Utilities
" Allow buffers to be hidden
set hidden

" Save folds when closing buffer
" NOTE: Very buggy. Don't rely on it, especially with macvim
augroup remember_folds
	autocmd!
	autocmd BufWinLeave * mkview
	autocmd BufWinEnter * silent! loadview
augroup END

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
