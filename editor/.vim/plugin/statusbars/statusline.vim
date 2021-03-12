" Very minimal statusline for vim
" Supports vanilla vim 8.0 and up

    " Always show
set laststatus=2

" ========================================================
" # Statusline highlights
" ====================================================={{{
let g:StatlnOnPrimaryColor = '#3A3A3A'
let g:StatlnSubtle = '#DAB994'
let g:StatlnSubtleBG = '#4E4E4E'
let g:StatlnPrimaryColor =   '#FF0000'
let g:StatlnIdle = '#FFAF00'
let g:StatlnIdleBG = '#222222'

" Updates statusline colors
function! ReloadStatlnColors()
    execute 'highlight StatlnPrimaryHL guifg=' . g:StatlnOnPrimaryColor . ' guibg=' . g:StatlnPrimaryColor ' term=bold cterm=bold gui=bold'
    execute 'highlight StatlnPrimaryToSubtleHL guifg=' . g:StatlnSubtleBG . ' guibg=' . g:StatlnPrimaryColor
    execute 'highlight StatlnSubtleToPrimaryHL guifg=' . g:StatlnPrimaryColor . ' guibg=' . g:StatlnSubtleBG
    execute 'highlight StatlnSubtleHL guifg=' . g:StatlnSubtle . ' guibg=' . g:StatlnSubtleBG
    execute 'highlight StatlnSubtleToIdleHL guifg=' . g:StatlnIdleBG . ' guibg=' . g:StatlnSubtleBG
    execute 'highlight StatlnIdleToSubtleHL guifg=' . g:StatlnSubtleBG . ' guibg=' . g:StatlnIdleBG
    execute 'highlight StatlnIdleHL guifg=' . g:StatlnIdle ' guibg=' . g:StatlnIdleBG
    execute 'highlight StatlnIdleInverseHL guifg=' . g:StatlnIdleBG ' guibg=' . g:StatlnIdle
endfunction

" }}}


" ========================================================
" # Statusline helper functions
" ====================================================={{{
" Returns the current git branch, or an empty string
" TODO: Constant reloading echos errors, if no branch is found
function! GitBranch()
    let l:branch = system('git branch --show-current')

    let l:is_branch = l:branch !~ ' '

    " Removes return char from name
    return [l:branch[:-2], l:is_branch]
endfunction


" Modified buffer indicator
function! StatlnModified()
    let l:is_modified = getbufinfo(bufnr('%'))[0].changed

    let l:modified_marker = ''

    if l:is_modified && &readonly
        " Ah! You modified a read-only buffer
        let l:modified_marker = '[!]'
    elseif l:is_modified
        let l:modified_marker = '[+]'
    elseif &readonly
        let l:modified_marker = '[-]'
    else
        return '' " Will not add a tailing space
    endif

    return l:modified_marker
endfunction 


" Current mode as pretty string
function! StatlnMode()
    let l:mode = mode()

    if l:mode ==# 'n'
        let g:StatlnPrimaryColor = '#AFAF00'  " Light green
        let b:mode_str = 'NORMAL'
    elseif l:mode ==# 'i'
        let g:StatlnPrimaryColor = '#83ADAD'  " Light blue
        let b:mode_str = 'INSERT'
    elseif l:mode ==# 'R'
        let g:StatlnPrimaryColor = '#D75F5F'  " Light red
        let b:mode_str = 'REPLACE'
    elseif l:mode ==# 's'
        let g:StatlnPrimaryColor = '#85AD85'  " Turquoise
        let b:mode_str = 'SELECT'
    elseif l:mode ==# 'c'
        let g:StatlnPrimaryColor = '#85AD85'  " Turquoise
        let b:mode_str = 'COMMAND'
    elseif l:mode ==# '!'
        let g:StatlnPrimaryColor = '#85AD85'  " Turquoise
        let b:mode_str = 'SHELL'
    elseif l:mode ==# 't'
        let g:StatlnPrimaryColor = '#85AD85'  " Turquoise
        let b:mode_str = 'TERM'
    elseif l:mode ==# 'v'
        let g:StatlnPrimaryColor = '#D485AD'  " Pink/light purple
        let b:mode_str = 'VISUAL'
    elseif l:mode ==# 'V'
        let g:StatlnPrimaryColor = '#D485AD'  " Pink/light purple
        let b:mode_str = "V-LINE"
    elseif l:mode ==# "\<C-v>"
        let g:StatlnPrimaryColor = '#D485AD'  " Pink/light purple
        let b:mode_str = "V-BLOCK"
    else
        let g:StatlnPrimaryColor = '#85AD85'  " Turquoise
        let b:mode_str = 'UNKNOWN'
    endif

    call ReloadStatlnColors()

        " You'd think it's infinitely recursive, though it seems to work???
    set tabline=%!TabLine()

    return b:mode_str . ' '
endfunction

" Left aligned column number at least 3 characters wide
" Intended to stop the statusline for expanding for low column numbers
function! ColumnNumber()
    let l:nr = col('.')

    if len(l:nr) < 3
        return printf('%-2S', l:nr)
    else
        return l:nr
    endif
endfunction


" }}}


" ========================================================
" # Build and reload Statusline
" ====================================================={{{
" Statusline for active window
    " Much more detailed
function! ActiveStatusline()
    call ReloadStatlnColors()

    let &l:stl=''
    let &l:stl.='%#StatlnPrimaryHL#'
    let &l:stl.=' '
    let &l:stl.='%{StatlnMode()}' " Current mode
    let &l:stl.='%#StatlnPrimaryToSubtleHL#'
    let &l:stl.=' '
    let &l:stl.='%#StatlnSubtleHL#'
    let &l:stl.=' '

    " Powerline:
    "                    

    " Shows git branch, i there is one
    "let b:git_branch = GitBranch()
    "echom b:git_branch[0] ' ' . ' ' . b:git_branch[1]
    "if b:git_branch[1]
    "    echom 'Setting branch'
    "    let &stl.=''
    "    let &stl.='%{b:git_branch[0]}'
    "    let &stl.=' '
    "endif

    let &l:stl.='%t'
    let &l:stl.=' '
    let &l:stl.='%{StatlnModified()}'
    let &l:stl.='%#StatlnSubtleToIdleHL#'
    let &l:stl.=' '
    let &l:stl.='%#StatlnIdleHL#'

    " Right side
    let &l:stl.='%=' " Right align
    let &l:stl.='%#StatlnIdleToSubtleHL#'
    let &l:stl.=' '
    let &l:stl.='%#StatlnSubtleHL#'
    let &l:stl.='%y' " File type
    "let &l:stl.=' '
    let &l:stl.='%#StatlnSubtleToPrimaryHL#'
    let &l:stl.=' '
    let &l:stl.='%#StatlnPrimaryHL#' " Same color as left side displaying mode
    "let &l:stl.=' '
    let &l:stl.='%p%%' " Percent through file
    let &l:stl.=' '
    let &l:stl.='☰'
    let &l:stl.=' '
    let &l:stl.='%{ColumnNumber()}' " Column number at least 2 characters wide
    let &l:stl.=' '
    let &l:stl.='%l/%L' " Current / Total lines
    let &l:stl.=' '
    "set statusline+=\ File:\ %t%M
    " https://shapeshed.com/vim-statuslines/
    " https://www.reddit.com/r/vim/comments/ld8h2j/i_made_a_status_line_from_scratch_no_plugins_used/
    "  
endfunction


" Status line for all inactive windows 
    " Little detail with em-dash seperators
function! IdleStatusline()
    call ReloadStatlnColors()
    set fillchars=stlnc:— " All empty space filled with em-dashes

    let &l:stl=''
    let &l:stl.='%#StatlnIdleHL#'  " Background same as editor
    let &l:stl.='—————————— '  " Left padding to align file name with active stl
    let &l:stl.='%t'  " File basename
    let &l:stl.=' '  " Align modified symbol with active stl
    let &l:stl.='%{StatlnModified()}'  " File basename
    " if &modified
    "     let &l:stl.=' '  " Indicates modifed buffer
    "     let &l:stl.='%m'  " Indicates modifed buffer
    "     let &l:stl.=' '
    " endif
    let &l:stl.=' '

endfunction


augroup SetStatusLine
    autocmd!
    au BufEnter,WinEnter * call ActiveStatusline()
    au BufLeave,WinLeave * call IdleStatusline()
augroup end

" }}}
