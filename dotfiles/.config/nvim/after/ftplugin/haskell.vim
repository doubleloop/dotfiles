setlocal tags+=codex.tags;/
" setlocal omnifunc=necoghc#omnifunc

let g:necoghc_use_stack = 1
let g:necoghc_enable_detailed_browse = 1
let g:tagbar_type_haskell = {
    \ 'ctagsbin'  : 'hasktags',
    \ 'ctagsargs' : '-x -c -o-',
    \ 'kinds'     : [
        \  'm:modules:0:1',
        \  'd:data: 0:1',
        \  'd_gadt: data gadt:0:1',
        \  't:type names:0:1',
        \  'nt:new types:0:1',
        \  'c:classes:0:1',
        \  'cons:constructors:1:1',
        \  'c_gadt:constructor gadt:1:1',
        \  'c_a:constructor accessors:1:1',
        \  'ft:function types:1:1',
        \  'fi:function implementations:0:1',
        \  'o:others:0:1'
    \ ],
    \ 'sro'        : '.',
    \ 'kind2scope' : {
        \ 'm' : 'module',
        \ 'c' : 'class',
        \ 'd' : 'data',
        \ 't' : 'type'
    \ },
    \ 'scope2kind' : {
        \ 'module' : 'm',
        \ 'class'  : 'c',
        \ 'data'   : 'd',
        \ 'type'   : 't'
    \ }
\ }

let g:hlintRefactor#disableDefaultKeybindings = 1
let g:neomake_haskell_ghc_mod_args = '-g-Wall'
let g:hoogle_search_jump_back = 0
nmap <leader>hc :GhcModCheckAndLintAsync<cr>
nmap <leader>hr :call ApplyOneSuggestion()<cr>
nmap <leader>ht :GhcModType<cr>
nmap <leader>hT :GhcModTypeInsert<cr>
nmap <leader>hh :Hoogle<cr>
nmap <leader>hH :Hoogle
nmap <leader>hi :HoogleInfo<cr>
nmap <leader>hI :HoogleInfo
nmap <leader><leader> :GhcModTypeClear<cr>:nohl<cr>


