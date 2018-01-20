setl tags+=codex.tags;/
setl ts=2 sts=2 sw=2
let g:neoformat_enabled_haskell = ['hindent']
" setl omnifunc=necoghc#omnifunc

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
nmap <buffer> <leader>hc :GhcModCheckAndLintAsync<cr>
nmap <buffer> <leader>hr :call ApplyOneSuggestion()<cr>
nmap <buffer> <leader>hR :call ApplyAllSuggestions()<cr>
nmap <buffer> <leader>ht :GhcModType<cr>
nmap <buffer> <leader>hT :GhcModTypeInsert<cr>
nmap <buffer> <leader>hh :Hoogle<cr>
nmap <buffer> <leader>hH :Hoogle
nmap <buffer> <leader>hi :HoogleInfo<cr>
nmap <buffer> <leader>hI :HoogleInfo
nmap <buffer> <leader><leader> :GhcModTypeClear<cr>:nohl<cr>
nmap <buffer> <leader>hc :Neomake ghcmod<cr>
nmap <buffer> <leader>hl :Neomake hlint<cr>

