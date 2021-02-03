"sync vim configs with neovim
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
" =============================================
" Install plugins
" =============================================
call plug#begin('~/.vim/plugged')

" Searching
" Plug 'junegunn/fzf'
" Plug 'junegunn/fzf.vim'

" Syntactic language support
Plug 'rust-lang/rust.vim'

call plug#end()


if has('nvim')
	set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
	set inccommand=nosplit
end

"colors
if !has('gui_running')
	set t_Co=256
endif

set background="dark"
let base16colorspace=256
colorscheme base16-gruvbox-dark-pale
syntax on
set termguicolors
