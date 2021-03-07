" Load vim configs for all clients (vim/neovim etc)
source ~/.vim/common_init.vim

" Tail of active buffer
set guitablabel=%t " Does not work for airline

" Experimental ===========================================
" Save folds when closing buffer
" NOTE: Very buggy. Don't rely on it, especially with macvim
augroup remember_folds
    autocmd!
    autocmd BufWinLeave + mkview
    autocmd BufWinEnter + silent! loadview
augroup END

" Convenience grepping
nnoremap <leader>gn :execute ":normal! :cnext\r"<CR>
nnoremap <leader>gN :execute ":normal! :cprevious\r"<CR>

set backspace=eol,start,indent " ???

