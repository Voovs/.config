" =============================================
" Global configs (unlikely to change)
" =========================================={{{
"sync vim configs with neovim
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

" Welcome prompt for seperating source error messages
echom "UwU"

" Open nvim/init.vim for quick editing
command! Nim :normal! :vsplit $MYVIMRC<CR><C-w>H
command! Nims :normal! :w<CR>:source $MYVIMRC<CR>:x<CR>

" Reset cursor to vertical bar when leaving
"au VimLeave * set guicursor=a:ver0-blinkon0
"au VimLeave * call nvim_cursor_set_shape("vertical-bar")

"}}}

" =============================================
" Install plugins
" =========================================={{{
call plug#begin('~/.vim/plugged')

" Searching
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" See tailing spaces
"TODO: setup this plug?
"Plug 'Yggdroot/indentLine'

" fuzzy searching buffers/files
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Syntactic language support
Plug 'rust-lang/rust.vim'

call plug#end()

" FZF for buffers, files, and grep
    " Window at the bottom with no preview
let g:fzf_layout = { 'down': '~20%' }
let g:fzf_preview_window = []

    " Only use ripgrep-searchable files, which takes .gitignore into account
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, {'source': 'rg --files .',
  \                               'options': '--tiebreak=index'}, <bang>0)

    " Open hotkeys for fzf
nnoremap <C-p> :Files<CR>
nnoremap <leader>; :Buffers<CR>

    " Use ripgrep with fzf (from Jonhoo)
noremap <leader>s :Rg<CR>
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)


" Prettier fzf colors
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


" Pretty tabs
let g:airline#extensions#tabline#enabled = 1  " Always display tabs
"let g:airline#extensions#tabline#formatter = 'unique_tail_improved' " Temporarily broken?
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#show_buffers = 0 " Don't show buffers
let g:airline#extensions#tabline#fnamemod = ':t' " Only show file tail
let g:airline#extensions#tabline#show_splits = 0 " No borders between tabs

" Use ripgrep
set grepprg=rg\ --vimgrep
set grepformat=%f:%l:%c:%m

if has('nvim')
    set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
    set inccommand=nosplit
end

"}}}

" =============================================
" Colors!!!
" =========================================={{{
" Customized to match base16-gruvbox-dark-pale
let g:airline_theme = 'base16_gruvbox_dark_hard'

if !has('gui_running')
    set t_Co=256
endif

"}}}
