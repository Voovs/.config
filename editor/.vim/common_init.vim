set runtimepath^=~/.vim runtimepath+=~/.vim/after

" ========================================================
" # Keyboard shortcuts
" ====================================================={{{
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
" Works in neovim not vanilla vim
tnoremap <C-k> <ESC>

" Navigation =========================================
" Jump to line start/end using homerow
noremap H ^
noremap L $

" Move by lines
nnoremap j gj
nnoremap k gk

" Case insensitive search
nnoremap <leader>/ /\c

" Command prompt =========================================
" ; as : for commands
nnoremap ; :

" Bash-like jump to start in command prompt
cnoremap <C-a> <C-b>

" Suspend with Ctrl+f
inoremap <C-f> <esc>:sus<CR>
vnoremap <C-f> :sus<CR>
nnoremap <C-f> :sus<CR>

" Windows and buffers ====================================
" Switch buffers
nnoremap <leader>n :bnext<CR>
nnoremap <leader>N :bprevious<CR>

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

    " Vertical resizing
nnoremap <leader><leader>, 10<C-w>+
nnoremap <leader><leader>. 10<C-w>-

    " Set interior window width or 80 lines
nnoremap <leader><leader>= :vertical resize 84<CR>

" Editing remaps ========================================
" Uppercase previous word from Insert mode
inoremap <C-u> <ESC>vbU`>a

    " Paste in insert mode
inoremap <C-p> <ESC>pa

" }}}

" ========================================================
" File editing
" ========================================================{{{
" Tidy vimrc with folds
augroup vimrc_folds
    " Mark folds with \{\{\{
    au Filetype vim setlocal foldmethod=marker
    " Open .vim files folded
    au Filetype vim,BufReadPre setlocal foldlevelstart=0
augroup END

" Open .vimrc for quick editing
command! Vim :normal! :vsplit ~/.vimrc<CR><C-w>H
command! Vims :normal! :w<CR>:source ~/.vimrc<CR>:x<CR>

" Open common_init.vim (here) for quick editing
command! Cim :normal! :vsplit ~/.vim/common_init.vim<CR><C-w>H
command! Cims :normal! :w<CR>:source ~/.vim/common_init.vim<CR>:x<CR>

" A place to quickly take a note
command! Note :split ~/.vim/vim_notepad.md

" Move to live above/below when at the start/end of line
set whichwrap+=>,l " end of line above on h
set whichwrap+=<,h " start of line below on l

" Tabs to spaces
set expandtab       " tabs are space
set tabstop=4       " number of spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4    " number of spaces to use for autoindent
set autoindent
set copyindent      " copy indent from the previous line

" Vim's auto-indenting is broken without this
filetype plugin indent on

" Mark trailing whitespace with • ========================
    " Toggle with :set invlist
set list
set listchars=tab:•\ ,trail:•,extends:•,precedes:•

    " Hide whitespace marker in insert, otherwise it's too distracting
augroup trailing_whitespace
    au!
    au InsertEnter * setlocal nolist
    au InsertLeave * setlocal list
augroup END
" Allow buffers to be hidden

set hidden

" Spelling substitutions
iabbrev em —
iabbrev @@! vselin12@gmail.com

" Autocompletion for wrappers (if you're into that sort of thing)
"inoremap " ""<left>
"inoremap ' ''<left>
"inoremap ( ()<left>
"inoremap [ []<left>
"inoremap { {}<left>
"inoremap < <><left>
"inoremap {<CR> {<CR>}<ESC>O
"inoremap {;<CR> {<CR>};<ESC>O
" }}}

" ========================================================
" External plugins
" ====================================================={{{
" Download vimplug, if not already installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin('~/.vim/plugged')

    " Starts vim in root git directory
Plug 'airblade/vim-rooter'
    " Shows line indent guides
Plug 'Yggdroot/indentLine'
    " fuzzy searching buffers/files  
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }      
Plug 'junegunn/fzf.vim'
    " Syntactic language support
Plug 'rust-lang/rust.vim'

call plug#end()

" No prompt when vim-rooter causes a directory change
let g:rooter_silent_chdir = 1

" Disables by default. See language specific section for when it's enabled
let g:indentLine_enabled = 0

" FZF setup ==============================================
    " Open hotkeys for fzf
nnoremap <C-p> :Files<CR>
nnoremap <leader>; :Buffers<CR>

    " Window at the bottom with no preview
let g:fzf_layout = { 'down': '~20%' }
let g:fzf_preview_window = []


    " Only use files ripgrep searches, which follows .gitignore
let $FZF_DEFAULT_COMMAND = 'rg --files'

    " Use ripgrep with fzf (from Jonhoo)
noremap <leader>s :Rg<CR>
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)


    " FZF colors match vim colorscheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

"}}}

" ========================================================
" # GUI settings
" ====================================================={{{
" Relative numbering, except absolute for current line
set number relativenumber

" Scroll before hitting top or bottom of window
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

" 80 char marker
set colorcolumn=80

" Highlight active line except in insert mode
au InsertEnter,InsertLeave * set cul!
set cursorline

" Line cursor in insert mode, block cursor everywhere else
" Might not work in some terminals. Might also trap your cursor in block,
" even after exiting vim
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" Colors and fonts =======================================
" Wider spaced Menlo font with Nerd Font glyphs
set guifont=MesloLGM\ Nerd\ Font:h16

" Live incremental searches
set hlsearch incsearch

" Colorful vim ===========================================
if !has('gui_running')
    set t_Co=256
endif
if (match($TERM, '-256color') != -1) && (match($TERM, 'screen-256color') == -1)
    " No true color for screen terminal
    set termguicolors " Actual colors
endif

set background=dark  " Doesn't seem to do anything, as colorscheme overrides
let base16colorspace=256
colorscheme base16-gruvbox-dark-pale  " From base16 vim repository
syntax on

" Bright comments (already adjusted in included colorscheme file)
call Base16hi("Comment", g:base16_gui09, "", g:base16_cterm09, "", "", "")
" }}}

" ========================================================
" Language specific
" ====================================================={{{
" Rust ===================================================
    " Rust's longer line standard
autocmd Filetype rust set colorcolumn=100

" Markdown ===============================================
    " Spelling in prose
autocmd Filetype markdown setlocal spell wrap linebreak
    " Break lines at 80 chars like gq
au BufRead,BufNewFile *.md setlocal textwidth=80

" Python =================================================
au Filetype python iabbrev <buffer> #! #!/usr/local/bin/python3

    " Bug fix for python interpreter seeing #!.../python3^M
au Filetype python set fileformat=unix

    " Indent guides for python
au Filetype python :IndentLinesToggle

" Motion to construct name
augroup function_name_movement
        " Python: function and class names
    au Filetype python onoremap ih :execute ":normal! ?def [A-z]\\+(\\\|class [A-z]*\\(:\\\|(\\)\r:noh\rwve"<CR>

        " Rust: fn, struct, and enum names
    au Filetype rust onoremap ih :execute ":normal! ?fn [a-z]\\+\\\|\\(struct\\\|enum\\) [A-Z]\r:noh\rwve"<CR>
augroup END

" }}}

" Environment ===========================================
let $BASH_ENV = '~/.bash_aliases'

" From Jonhoo, sets ripgrep as grep
if executable('rg')
    set grepprg=rg\ --no-heading\ --vimgrep
    set grepformat=%f:%l:%c:%m
endif
