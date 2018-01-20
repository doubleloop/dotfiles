let g:go_fmt_autosave = 0
let g:go_fmt_command = "goimports"
let g:go_autodetect_gopath = 1
let g:go_list_type = 'quickfix'
" let g:go_auto_type_info = 1
let g:go_auto_sameids = 1

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_generate_tags = 1
"
" Open :GoDeclsDir with ctrl-g
nmap <buffer> <C-g> :GoDeclsDir<cr>
imap <buffer> <C-g> <esc>:<C-u>GoDeclsDir<cr>

" Show by default 4 spaces for a tab
setl noexpandtab ts=4 sts=4 sw=4

" :GoBuild and :GoTestCompile
nmap <buffer> <leader>gb :<C-u>call <SID>build_go_files()<CR>

" :GoTest
nmap <buffer> <leader>gt  <Plug>(go-test)

" :GoRun
nmap <buffer> <leader>gr  <Plug>(go-run)<esc>

" :GoDoc
nmap <buffer> <Leader>gd <Plug>(go-doc)

" :GoCoverageToggle
nmap <buffer> <Leader>gc <Plug>(go-coverage-toggle)

" :GoInfo
nmap <buffer> <Leader>gi <Plug>(go-info)

" :GoMetaLinter
nmap <buffer> <Leader>gl <Plug>(go-metalinter)

nmap <buffer> <leader>gn <Plug>(go-referrers)

" :GoDef but opens in a vertical split
" nmap <buffer> <Leader>gv <Plug>(go-def-vertical)
" :GoDef but opens in a horizontal split
" nmap <buffer> <Leader>gs <Plug>(go-def-split)

" :GoAlternate  commands :A, :AV, :AS and :AT
command! -bang A call go#alternate#Switch(<bang>0, 'edit')
command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
command! -bang AS call go#alternate#Switch(<bang>0, 'split')
command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')

" build_go_files is a custom function that builds or compiles the test file.
" It calls :GoBuild if its a Go file, or :GoTestCompile if it's a test file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#cmd#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction
