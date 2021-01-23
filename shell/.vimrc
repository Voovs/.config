" ========================================================
" # GUI settings
" ========================================================
set number relativenumber
set scrolloff=2

" ========================================================
" # Keyboard shortcuts
" ========================================================
" ; as : for commandline
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

filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
" set expandtab

set hlsearch

syntax enable
if has('gui_running')
	set number
	set nowrap
    set background=light
    colorscheme base16-gruvbox-dark-pale
	set number relativenumber
else
	colo solarized
    colo base16-atelier-cave
endif

set guifont=Menlo\ Regular:h16


augroup remember_folds
	autocmd!
	autocmd BufWinLeave * mkview
	autocmd BufWinEnter * silent! loadview
augroup END

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
