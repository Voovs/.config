" Toggle a column to the left of numbers showing fold depth, 4 folds deep
nnoremap <leader>zf :call <SID>FoldColumnToggle()<CR>

function! s:FoldColumnToggle()
    if &foldcolumn
        setlocal foldcolumn=0
    else
        setlocal foldcolumn=4
    endif
endfunction
