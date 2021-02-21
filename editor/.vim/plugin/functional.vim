" Calls the closure over every item in the given list with the
" previous result of the closure. This effectively calls the closure
" for all the items together
"
" Consider this to be a cleaner `for` loop in most cases
"
" Examples:
"   :echo Fold([1, 2, 3], {a, b -> a + b})
"   6
"   :echo Fold(['a', 'b', 'c'], {a, b -> a . b})
"   abc
function! Fold(list, lambda)
    let accumulator = a:list[0]

    for item in a:list[1:]
        let accumulator = a:lambda(accumulator, item)
    endfor

    return accumulator
endfunction


" Splits given dictionary/list in two, based on a filter over the given
" function
"
" First item in returned list is data structure with all items that passed
" the filter. Second item is the opposite
"
" Example:
"     :echo Filtered({'a': 'aaa', 'b': '', 'c': 'aa'}, function('len'))
"     [{'a': 'aaa', 'c': 'aa'}, {'b': ''}]
function! Filtered(data, fn)
    let passed_filter = deepcopy(a:data)
    call filter(passed_filter, string(a:fn) . '(v:val)')

    let filtered_out = deepcopy(a:data)
    call filter(filtered_out, '!' . string(a:fn) . '(v:val)') 

    return [passed_filter, filtered_out]
endfunction 


" =========================================================================
" Functions below were taken from Steve Losh's Learn Vimscript The Hard Way
" Read it here: https://learnvimscriptthehardway.stevelosh.com/

" Returns a new sorted list
function! Sorted(list)
    let list_clone = deepcopy(a:list)
    call sort(list_clone)
    return list_clone
endfunction

" Returns a new reversed list
function! Reversed(list)
    let list_clone = deepcopy(a:list)
    call reverse(list_clone)
    return list_clone
endfunction

" Returns a new list with the val appended
function! Append(list, val)
    let list_clone = deepcopy(a:list)
    call add(list_clone, a:val)
    return list_clone
endfunction

" Returns a list clone mapped. Uses a bit of trickery
" with string concatenation to make a function call.
" call line expands to something like:
" :call map(list_clone, function('len')('v:val'))
function! Mapped(fn, list)
    let list_clone = deepcopy(a:list)
    call map(list_clone, string(a:fn) . '(v:val)')
    return list_clone
endfunction
