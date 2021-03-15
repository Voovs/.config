" Very minimal statusline for vim
" Supports vim 8.0 and up and neovim 0.4 and likely earlier versions

    " Always show
set laststatus=2

" ========================================================
" # Statusline highlights
" ====================================================={{{
let g:StatlnPrimaryColor =   '#FF0000'  " Also set as active tabline hue
let g:StatlnPrimaryFG =      '#3A3A3A'
let g:StatlnSubtle = '#DAB994'
let g:StatlnSubtleBG = '#4E4E4E'
let g:StatlnIdle = '#FFAF00'
let g:StatlnIdleBG = '#222222'

" Updates statusline colors
function! ReloadStatlnColors()
        " Hue of current mode
    execute 'highlight StatlnPrimaryHL guifg=' . g:StatlnPrimaryFG . ' guibg=' . g:StatlnPrimaryColor ' term=bold cterm=bold gui=bold'
        " Transitions to/from primary highlight
    execute 'highlight StatlnPrimaryToSubtleHL guifg=' . g:StatlnSubtleBG . ' guibg=' . g:StatlnPrimaryColor
    execute 'highlight StatlnSubtleToPrimaryHL guifg=' . g:StatlnPrimaryColor . ' guibg=' . g:StatlnSubtleBG

        " Secondary highlight, adjacent to primary highlight
    execute 'highlight StatlnSubtleHL guifg=' . g:StatlnSubtle . ' guibg=' . g:StatlnSubtleBG

    execute 'highlight StatlnSubtleToIdleHL guifg=' . g:StatlnIdleBG . ' guibg=' . g:StatlnSubtleBG
    execute 'highlight StatlnIdleToSubtleHL guifg=' . g:StatlnSubtleBG . ' guibg=' . g:StatlnIdleBG

        " Tertiary highlight. Used for inactive buffers and statusline's BG
    execute 'highlight StatlnIdleHL guifg=' . g:StatlnIdle ' guibg=' . g:StatlnIdleBG
    execute 'highlight StatlnIdleInverseHL guifg=' . g:StatlnIdleBG ' guibg=' . g:StatlnIdle
endfunction


" Sets primary color highlight for statusline and tabline, based on the mode
" Updates the name of the mode in the statusline
function! SetGlobalPrimaryColor()
    let l:mode = mode()  " Returns vim's current mode

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
endfunction

" }}}


" ========================================================
" # Statusline helper functions
" ====================================================={{{
" Returns the current git branch, or an empty string
function! StatlnGitBranch()
    let l:branch = system('git branch --show-current')

    if l:branch !~ ' '
        return '  '
    else
        return ''
    endif
endfunction


" Modified buffer indicator
function! StatlnModified()
    let l:is_modified = getbufinfo(bufnr('%'))[0].changed

    if l:is_modified && &readonly
        let l:modified_marker = '[!]'  " Ah! You modified a read-only buffer
    elseif l:is_modified
        let l:modified_marker = '[+]'
    elseif &readonly
        let l:modified_marker = '[-]'
    else
        let l:modified_marker = ''  " No indicator for unmodified normal buffer
    endif

    return l:modified_marker
endfunction



" Set the primary status/tabline color and the mode string
function! StatlnMode()
    call ReloadStatlnColors()

        " Redraws tabline and updates the global mode color
        " Required to synchronize tabline and statusline properly
    set tabline=%!TabLine()

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

    let l:s=''
    " Powerline:
    "                    

    " Left side =====================================================
        " Current mode bold and with a mode-specific background color
    let l:mode='%#StatlnPrimaryHL# %{StatlnMode()}%#StatlnPrimaryToSubtleHL# '
        " Current buffer's name and an indicator if it was modified
    let l:buff='%#StatlnSubtleHL# %t %{StatlnModified()}%#StatlnSubtleToIdleHL# '

        " Shows git branch, if there is one
    "let l:git_branch = StatlnGitBranch()

    let l:left_side = l:mode . l:buff . '%#StatlnIdleHL#'

    " Right side ====================================================
    let l:trans_from_gap='%#StatlnIdleToSubtleHL# '
        " File type
    let l:file_type='%#StatlnSubtleHL#%y%#StatlnSubtleToPrimaryHL# '
        " Same color as far left mode background
        " Percent through the file
    let l:percent_down='%#StatlnPrimaryHL#%p%% ☰ '
        " Column and line / total lines
    let l:cursor_pos='%2c %l/%L '

    let l:right_side='%=' . l:trans_from_gap . l:file_type . l:percent_down . l:cursor_pos

    return l:left_side . l:right_side

    " https://shapeshed.com/vim-statuslines/
    " https://www.reddit.com/r/vim/comments/ld8h2j/i_made_a_status_line_from_scratch_no_plugins_used/
endfunction


" Status line for all inactive windows
    " Little detail with em-dash seperators
function! IdleStatusline()
    call ReloadStatlnColors()
    set fillchars=stlnc:— " All empty space filled with em-dashes

        " Left padding to align file name with active stl.
        " Same background as editor makes it very minimalist
    return '%#StatlnIdleHL#—————————— %t %{StatlnModified()} '
endfunction


augroup SetStatusLine
    autocmd!
    au BufEnter,WinEnter * let &l:stl = ActiveStatusline()
    au BufLeave,WinLeave * let &l:stl = IdleStatusline()

        " Updates status/tabline when entering command prompt
    au CmdlineEnter * redraw
augroup end

" }}}
