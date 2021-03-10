" Creates a simple lightweight tabline intended for vanilla vim

" Always display tabline
set showtabline=2

" ========================================================
" # TODO Weather notification TODO
" ====================================================={{{
function! Weather()
    let l:forecasts = GetForecast()

    if l:forecasts[0]
        " First index is to unwrap tuple returned by GetForecast()
        " Forecast in 3 hours
        let l:next_forecast = l:forecasts[1][0]['weather'][0]

        " TODO: Change tabsline instead of just echoing
        echom WeatherCondition(l:next_forecast)
    else
        " TODO: Better error reporting in tabline
        echom 'Error: `' . l:forecasts[1] . '`'
    endif
endfunction

" Tries to grab the weather off OpenWeather
"
" Returns:
"   First item indicates the api call was successful. Second item contains
"   relevent data returned by the api
"
"   [1, list]: List of forecasts in 3h intervals
"   [0, str]: String is the error message from the server
function! GetForecast()
    " Makes request for json
    let l:response = system('curl --silent ''http://api.openweathermap.org/data/2.5/forecast?q=edmonton&appid=317f9cc8efd9ce81736994c0497eb7b2''')
    let l:json = json_decode(l:response)
    " let l:unix_epoch = str2nr(system('date +"%s"'))

    " Success case is code 200
    if l:json['cod'] ==# '200'
        " List of forecasts in 3h intervals
        return [1, l:json['list']]
    else
        return [0, l:json['message']]
    endif
endfunction


" Returns a simple string for the general idea of the weather conditions
" Arg:
"   forecast (dict): one time's forecast dictionary, parsed from json
"
" Return:
"   str: General idea of the weather
function! WeatherCondition(forecast)
    " Numerical identification for weather conditions
    " See id codes here: https://openweathermap.org/weather-conditions
    let l:forecast_id = a:forecast['id']

    if l:forecast_id[:0] ==# '2'
        " Thunderstorm
        return 'Thunderstorm'
    elseif l:forecast_id[:0] ==# '5' || l:forecast_id[:0] ==# '3'
        " Rain or `drizzle`
        return 'Rain'
    elseif l:forecast_id[:0] ==# '6'
        " Snow
        return 'Snow'
    elseif l:forecast_id[:0] ==# '8'
        " Cloudly or clear. Nothing exciting
        return 'Normal'
    elseif l:forecast_id[:0] ==# '7'
        " Atmospheric abnormality ex: Dust, Smoke, Sand, Tornado
        if l:forecast_id ==# '781'
            " Tornado!
            return 'Tornado'
        elseif l:forecast_id ==# '711'
            " Smoke
            return 'Smoke'
        elseif l:forecast_id ==# '741'
            " Fog
            return 'Fog'
        elseif l:forecast_id ==# '761'
            " Dust
            return 'Dust'
        else
            return 'Atomspheric abnormality'
        endif
    else
        " Error: should have matched above
        return 'Error: Failed to find weather condition code `' . l:forecast_id . '`'
    endif
endfunction

" }}}

" ========================================================
" # Tabline highlights
" ====================================================={{{
let g:TabLineActive = '#3A3A3A'  " Dark grey
let g:TabLineActiveBG = '#AFAF00'  " Light green
let g:TabLineIdle = '#DAB994'  " Warm white
let g:TabLineIdleBG = '#4E4E4E'  " Light grey

" Updates tabline colors
function! ReloadTabLineColors()
    " Active tab
    execute 'highlight TabLineActiveHL guifg=' . g:TabLineActive . ' guibg=' . g:TabLineActiveBG

    " Inactive (idle) tabs
    execute 'highlight TabLineIdleHL guifg=' . g:TabLineIdle . ' guibg=' . g:TabLineIdleBG

    " Active <-> Idle tabs transition, for powerline seperator
    execute 'highlight TabLineActiveToIdleHL guifg=' . g:TabLineActiveBG . ' guibg=' . g:TabLineIdleBG
    execute 'highlight TabLineIdleToActiveHL guifg=' . g:TabLineIdleBG . ' guibg=' . g:TabLineActiveBG
endfunction

" }}}

" ========================================================
" # Build TabLine
" ====================================================={{{

" Creates visual label/title for a tab
function! TabLabel(tab_num)
    let l:tab_label = ''

    " Different highlight for active tab =================
    if a:tab_num ==# tabpagenr()
            " Is active tab
        let l:tab_HL = '%#TabLineActiveHL#'
        let l:tab_trans_HL = '%#TabLineActiveToIdleHL#'
        let l:tab_seperator = ''
    elseif a:tab_num ==# tabpagenr() - 1
            " Tab right before active tab
        let l:tab_HL = '%#TabLineIdleHL#'
        let l:tab_trans_HL = '%#TabLineIdleToActiveHL#'
        let l:tab_seperator = ''
    else
            " Inactive tab not adjacent to active tab
        let l:tab_HL = '%#TabLineIdleHL#'
        let l:tab_trans_HL = '%#TabLineIdleHL#'
        let l:tab_seperator = ''
    endif

    let l:tab_label .= l:tab_HL

    " Ordered list of buffer ids open in the tab =========
    let l:buff_list = tabpagebuflist(a:tab_num)

        " Path to first buffer in the tab
    let l:curr_buff_path = bufname(l:buff_list[0])

        " Truncate file path to tail only
    let l:tab_title = fnamemodify(l:curr_buff_path, ':t')

    " Tab number, file name, powerline seperator =========
    let l:tab_label .=
    \ '  ' . a:tab_num . ' ' . l:tab_title . ' ' . l:tab_trans_HL . l:tab_seperator

    return l:tab_label
endfunction


function! TabLine()
    call ReloadTabLineColors()
    let s = ''
    let curr_n = tabpagenr()

    for i in range(tabpagenr('$'))
        let i += 1  " Start at index 1

        let s .= '%' . i . 'T'  " Mouse click support
        let s .= TabLabel(i)  " Visible tab lable
    endfor

    return s
endfunction

set tabline=%!TabLine()

" }}}
