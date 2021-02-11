" Specified function is called after movement are given to g@
" SID appends a unique local script number in front of the function
nnoremap <leader>gg :set operatorfunc=<SID>GrepOperator<CR>g@
" vim fills in :'<,'> from visual, <c-u> removes it
vnoremap <leader>gg :<c-u>call <SID>GrepOperator(visualmode())<CR>

" s: makes the function local to this script
function! s:GrepOperator(type)
    let saved_unnamed_reg = @@

    if a:type ==# 'v'
        " Moves to the beginning of mark, sets
        " v visual mode and copies to the end
        " of mark the mark
        " def
        normal! `<v`>y
    elseif a:type ==# 'char'
        normal! `[y`]
    else
        return
    endif

    silent execute ":grep! " . shellescape(@@) . " ."
    copen 10
    
    let @@ = saved_unnamed_reg 
endfunction
