" Very minimal statusline for vim
" No plugins beyond vanilla vim 8.0


" Set to only run in normal vim
" Remove if you aren't using another statusline in gui/neo vim
if !has('nvim') && !has('gui_running')

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
    execute 'highlight StatlnSubtleHL guifg=' . g:StatlnSubtle . ' guibg=' . g:StatlnSubtleBG
    execute 'highlight StatlnIdleHL guifg=' . g:StatlnIdle ' guibg=' . g:StatlnIdleBG
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
    echom 'before search'
    let l:is_modified = getbufinfo(bufnr('%'))[0].changed
    echom 'Modified?: ' . l:is_modified

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
        let g:StatlnPrimaryColor = '#AFAF00' 
        let b:mode_str = 'NORMAL'
    elseif l:mode ==# 'i'
        let g:StatlnPrimaryColor = '#83ADAD' 
        let b:mode_str = 'INSERT'
    elseif l:mode ==# 'R'
        let g:StatlnPrimaryColor = '#D75F5F'
        let b:mode_str = 'REPLACE'
    elseif l:mode ==# 's'
        let g:StatlnPrimaryColor = '#85AD85'
        let b:mode_str = 'SELECT'
    elseif l:mode ==# 'c'
        let g:StatlnPrimaryColor = '#85AD85'
        let b:mode_str = 'COMMAND'
    elseif l:mode ==# '!'
        let g:StatlnPrimaryColor = '#85AD85'
        let b:mode_str = 'SHELL'
    elseif l:mode ==# 't'
        let g:StatlnPrimaryColor = '#85AD85'
        let b:mode_str = 'TERM'
    elseif l:mode ==# 'v'
        let g:StatlnPrimaryColor = '#D485AD'
        let b:mode_str = 'VISUAL'
    elseif l:mode ==# 'V'
        let g:StatlnPrimaryColor = '#D485AD'
        let b:mode_str = "V-LINE"
    elseif l:mode ==# "\<C-v>"
        let g:StatlnPrimaryColor = '#D485AD'
        let b:mode_str = "V-BLOCK"
    else
        let g:StatlnPrimaryColor = '#85AD85'
        let b:mode_str = 'UNKNOWN'
    endif
    
    call ReloadStatlnColors()

    return b:mode_str . ' '
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
    let &l:stl.='%#StatlnSubtleHL#'
    let &l:stl.=' '

    " Shows git branch, i there is one
    "let b:git_branch = GitBranch()
    "echom b:git_branch[0] ' ' . ' ' . b:git_branch[1]
    "if b:git_branch[1]
    "    echom 'Setting branch'
    "    let &stl.='<'
    "    let &stl.='%{b:git_branch[0]}'
    "    let &stl.='> '
    "endif

    let &l:stl.='%t'
    let &l:stl.=' '
    let &l:stl.='%{StatlnModified()}'
    let &l:stl.='%#StatlnIdleHL#'

    " Right side
    let &l:stl.='%=' " Right align
    let &l:stl.='%#StatlnSubtleHL#'
    let &l:stl.=' '
    let &l:stl.='%y' " File type
    let &l:stl.=' '
    let &l:stl.='%#StatlnPrimaryHL#' " Same color as left side displaying mode
    let &l:stl.=' '
    let &l:stl.='%p%%' " Percent through file
    let &l:stl.=' '
    let &l:stl.='%l/%L' " Current / Total lines
    " %{\uE0B2}
    "set statusline+=\ File:\ %t%M
    " https://shapeshed.com/vim-statuslines/
    " https://www.reddit.com/r/vim/comments/ld8h2j/i_made_a_status_line_from_scratch_no_plugins_used/
endfunction


" Status line for all inactive windows 
    " Little detail with em-dash seperators
function! IdleStatusline()
    call ReloadStatlnColors()
    set fillchars=stlnc:— " All empty space filled with em-dashes

    let &l:stl=''
    let &l:stl.='%#StatlnIdleHL#'  " Background same as editor
    let &l:stl.='————————— '  " Slight padding on left
    let &l:stl.='%t'  " File basename
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

endif
