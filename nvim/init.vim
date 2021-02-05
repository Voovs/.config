"sync vim configs with neovim
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

" Welcome prompt for seperating source error messages
echom ">^.^<"

" Open nvim/init.vim for quick editing
nnoremap <leader>nvim :vsplit $MYVIMRC<CR><C-w>H
nnoremap <leader>nvims :source $MYVIMRC<CR>:x<CR>

" =============================================
" Install plugins
" =============================================
call plug#begin('~/.vim/plugged')

" Searching
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Plug 'junegunn/fzf'
" Plug 'junegunn/fzf.vim'

" See tailing spaces
Plug 'Yggdroot/indentLine'

" Syntactic language support
Plug 'rust-lang/rust.vim'

call plug#end()

" Pretty tabs
let g:airline#extensions#tabline#enabled = 1  " Always display tabs
"let g:airline#extensions#tabline#formatter = 'unique_tail_improved' " Temporarily broken?
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#show_buffers = 0 " Don't show buffers
let g:airline#extensions#tabline#fnamemod = ':t' " Only show file tail
let g:airline#extensions#tabline#show_splits = 0 " No borders between tabs

if has('nvim')
	set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
	set inccommand=nosplit
end

" =============================================
" Colors!!!
" =============================================
" Customized to match base16-gruvbox-dark-pale
let g:airline_theme = 'base16_gruvbox_dark_hard'

if !has('gui_running')
	set t_Co=256
endif

set background="dark"
let base16colorspace=256
colorscheme base16-gruvbox-dark-pale
syntax on
set termguicolors


" Reset cursor to vertical bar when leaving
"au VimLeave * set guicursor=a:ver0-blinkon0
"au VimLeave * call nvim_cursor_set_shape("vertical-bar")

