" neovim-npython installations
let g:python_host_prog = $PYTHON2_NVIM_VIRTUALENV
let g:python3_host_prog = $PYTHON3_NVIM_VIRTUALENV

let mapleader=","
" Plugins {{{
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  function! PrepareVim()
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    source $MYVIMRC
    PlugInstall --sync
    source $MYVIMRC
  endfunc
  command! Prep :call PrepareVim()
else
call plug#begin('~/.local/share/nvim/plugged')
Plug 'wikitopian/hardmode'
Plug 'takac/vim-hardtime'
let g:hardtime_default_on=0
let g:hardtime_allow_different_key = 1

Plug 'tpope/vim-repeat'    " Fix '.' key on some plugins
Plug 'tpope/vim-surround'  " Must have surround functionality
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'  " git integration
Plug 'tpope/vim-rhubarb'   " gihtub Gitbrowse
Plug 'tommcdo/vim-fubitive'  " bitbucket Gbrowse
Plug 'tpope/vim-unimpaired'  " Handy bracket mappings
Plug 'tpope/vim-sleuth'    " guess ts heuristically
let g:sleuth_automatic=0
" Plug 'tpope/vim-abolish'    " substitute imrpoved
Plug 'ericpruitt/tmux.vim'
Plug 'christoomey/vim-tmux-navigator'
let g:tmux_navigator_disable_when_zoomed = 1
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <a-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <a-j> :TmuxNavigateDown<cr>
nnoremap <silent> <a-k> :TmuxNavigateUp<cr>
nnoremap <silent> <a-l> :TmuxNavigateRight<cr>
nnoremap <silent> <a-\> :TmuxNavigatePrevious<cr>
inoremap <silent> <a-h> <esc>:TmuxNavigateLeft<cr>
inoremap <silent> <a-j> <esc>:TmuxNavigateDown<cr>
inoremap <silent> <a-k> <esc>:TmuxNavigateUp<cr>
inoremap <silent> <a-l> <esc>:TmuxNavigateRight<cr>
inoremap <silent> <a-\> <esc>:TmuxNavigatePrevious<cr>
vnoremap <silent> <a-h> <esc>:TmuxNavigateLeft<cr>
vnoremap <silent> <a-j> <esc>:TmuxNavigateDown<cr>
vnoremap <silent> <a-k> <esc>:TmuxNavigateUp<cr>
vnoremap <silent> <a-l> <esc>:TmuxNavigateRight<cr>
vnoremap <silent> <a-\> <esc>:TmuxNavigatePrevious<cr>
cnoremap <silent> <a-h> <c-c>:TmuxNavigateLeft<cr>
cnoremap <silent> <a-j> <c-c>:TmuxNavigateDown<cr>
cnoremap <silent> <a-k> <c-c>:TmuxNavigateUp<cr>
cnoremap <silent> <a-l> <c-c>:TmuxNavigateRight<cr>
cnoremap <silent> <a-\> <c-c>:TmuxNavigatePrevious<cr>

Plug '907th/vim-auto-save'
let g:auto_save = 1
let g:auto_save_in_insert_mode = 0
let g:auto_save_silent = 1
let g:auto_save_events = ["CursorHold", "FocusLost", "BufHidden", "ExitPre"]

if !empty(glob('/usr/share/doc/fzf/examples/fzf.vim'))
  source /usr/share/doc/fzf/examples/fzf.vim
else
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
endif
Plug 'junegunn/fzf.vim'
let g:fzf_command_prefix = 'Fzf'
Plug 'pbogut/fzf-mru.vim'
nnoremap <leader>p :FzfFiles<cr>
nnoremap <leader>P :FzfCommands<cr>
nnoremap <leader>b :FzfBuffer<cr>
nnoremap <leader>m :FZFMru<cr>
nnoremap <leader>l :FzfBLines<cr>
nnoremap <a-e> :FzfBTags<cr>

Plug 'mileszs/ack.vim'
if executable('rg')
  let g:ackprg = 'rg --vimgrep'
  set grepprg=rg\ --vimgrep
  set grepformat=%f:%l:%c:%m
elseif executable('ag')
  let g:ackprg = 'ag --vimgrep'
  set grepprg=ag\ --vimgrep
  set grepformat=%f:%l:%c:%m
endif

Plug 'rhysd/vim-grammarous'

" Mirroring files on various remote hosts
Plug 'zenbro/mirror.vim'
" push/pull to remote host (mirror plugin)
nnoremap <leader>rr :MirrorPush<cr>
nnoremap <leader>rd :MirrorDiff<cr>
nnoremap <leader>rl :MirrorReload<cr>

Plug 'troydm/zoomwintab.vim'
let g:zoomwintab_remap = 0
nnoremap <silent> <c-w>z :ZoomWinTabToggle<cr>
vnoremap <silent> <c-w>z <c-\><c-n>:ZoomWinTabToggle<cr>gv

Plug 'Shougo/vinarise.vim' " hex editor

" Various text objects
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-line' " l
Plug 'mattn/vim-textobj-url' " u
Plug 'bps/vim-textobj-python', {'for': ['python', 'python3']}
Plug 'wellle/targets.vim'

Plug 'vim-scripts/ReplaceWithRegister' " gr
Plug 'christoomey/vim-sort-motion'     " gs
Plug 'AndrewRadev/splitjoin.vim'       " gJ gS

Plug 'airblade/vim-gitgutter' " show git changes
let g:gitgutter_map_keys = 0
nmap [c <Plug>(GitGutterPrevHunkzt)
nmap ]c <Plug>(GitGutterNextHunkzt)
nmap <leader>hp <Plug>(GitGutterPreviewHunk)

Plug 'kshenoy/vim-signature'  " show marks

" Nice left panel with tree structured files
Plug 'scrooloose/nerdtree'
let g:NERDTreeQuitOnOpen = 0
let g:NERDTreeHighlightCursorline = 0
let g:NERDTreeWinSize = 40
let g:NERDTreeMinimalUI = 1
function! ToggleNerd()
  if exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
    exec ':NERDTreeToggle'
  elseif filereadable(expand("%p"))
    exec ':NERDTreeFind'
  else
    exec ':NERDTree'
  endif
endfunction
nnoremap <a-1> <esc>:call ToggleNerd()<cr>
Plug 'xuyuanp/nerdtree-git-plugin'

" Help alligning text
Plug 'godlygeek/tabular'
" Plug 'dhruvasagar/vim-table-mode'

" Improved sessions
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'
let g:session_autosave='yes'
let g:session_autoload='no'
let g:session_default_overwrite=1
let g:session_autosave_periodic='1'
let g:session_autosave_silent=1
let g:session_default_to_last=1
let g:session_command_aliases=1
let g:session_persist_colors=0
let g:session_persist_font=0
let g:session_directory="~/.local/share/nvim/sessions"
nnoremap <leader>so :SessionOpen<cr>

Plug 'moll/vim-bbye'

Plug 'machakann/vim-swap'
let g:swap_no_default_key_mappings = 1
nmap g< <Plug>(swap-prev)
nmap g> <Plug>(swap-next)
nmap g? <Plug>(swap-interactive)
xmap g? <Plug>(swap-interactive)

Plug 'vimwiki/vimwiki', { 'branch': 'dev' }
let g:vimwiki_list = [{'path': '~/workspace/vimwiki'}]
" Changes Vim working directory to project root
" Plug 'airblade/vim-rooter'
" let g:rooter_silent_chdir = 1
" let g:rooter_patterns = ['.vim_root']
" let g:rooter_manual_only = 1

" Eclipse like autoopening of quotes/parenthesis
Plug 'raimondi/delimitmate'
let g:delimitMate_expand_cr = 1

" Plug 'kien/rainbow_parentheses.vim'
Plug 'RRethy/vim-illuminate'
let g:Illuminate_delay = 500

" Panel with tags
Plug 'majutsushi/tagbar'
let g:tagbar_autoclose = 0
let g:tagbar_iconchars = ['▸', '▾']
nnoremap <a-2> :TagbarToggle<cr>
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
let g:tagbar_type_rust = {
    \ 'ctagstype' : 'rust',
    \ 'kinds' : [
        \'T:types,type definitions',
        \'f:functions,function definitions',
        \'g:enum,enumeration names',
        \'s:structure names',
        \'m:modules,module names',
        \'c:consts,static constants',
        \'t:traits',
        \'i:impls,trait implementations',
    \]
    \}

Plug 'mbbill/undotree'
nnoremap <leader>u :UndotreeToggle<cr>

" Python
Plug 'Vimjas/vim-python-pep8-indent', { 'for': ['python', 'python3']}
Plug 'tmhedberg/SimpylFold',          { 'for': ['python', 'python3']}
" Plug 'bfredl/nvim-ipy',             { 'do': ':UpdateRemotePlugins' }
" let g:nvim_ipy_perform_mappings = 0
Plug 'BurningEther/iron.nvim',      { 'do': ':UpdateRemotePlugins' }
let g:iron_map_defaults = 0
nmap <F5> <Plug>(iron-send-line)
vmap <F5> <Plug>(iron-visual-send)
nmap <F8> <Plug>(iron-interrupt)

" C/C++
" switch to/from heade file with :A
Plug 'vim-scripts/a.vim',             { 'for': ['c', 'cpp']}
Plug 'justinmk/vim-syntax-extra'

Plug 'lervag/vimtex',                 { 'for': 'tex' }
let g:tex_flavor='latex'
let g:vimtex_compiler_progname = 'nvr'

Plug 'plasticboy/vim-markdown',       { 'for': 'markdown' }
let g:vim_markdown_folding_disabled = 1
function! BuildComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    !cargo build --release
  endif
endfunction
Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }
let g:markdown_composer_open_browser = 0

Plug 'stephpy/vim-yaml',              { 'for': 'vim' }
Plug 'glench/vim-jinja2-syntax',      { 'for': 'jinja' }
Plug 'mfukar/robotframework-vim',     { 'for': 'robot' }
Plug 'roalddevries/yaml.vim',         { 'for': 'yaml' }
Plug 'ekalinin/dockerfile.vim',       { 'for': 'Dockerfile' }
Plug 'momota/junos.vim',              { 'for': 'junos' }
Plug 'let-def/vimbufsync'
Plug 'the-lambda-church/coquille',    { 'branch': 'pathogen-bundle' }

" Autocompletion engine
Plug 'haorenW1025/completion-nvim'
let g:completion_enable_snippet = 'Neosnippet'
let g:completion_sorting = "length"
let g:completion_enable_auto_hover = 1
let g:completion_trigger_on_delete = 1
let g:completion_chain_complete_list = {
  \ 'python': {
  \   'string': [
  \     {'mode': 'c-n'}
  \   ],
  \   'default': [
  \     {'complete_items': ['lsp']},
  \     {'complete_items': ['snippet']}
  \   ]
  \ },
  \ 'default': [
  \   {'complete_items': ['lsp']},
  \   {'complete_items': ['snippet']},
  \   {'mode': '<c-n>'},
  \ ]}
imap <c-j> <cmd>lua require'source'.nextCompletion()<cr>
imap <c-k> <cmd>lua require'source'.prevCompletion()<cr>
let g:completion_auto_change_source = 1

Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
imap <expr><TAB>
      \ neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

smap <expr><TAB>
      \ neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

Plug 'neovim/nvim-lsp'
Plug 'haorenW1025/diagnostic-nvim'
let g:diagnostic_insert_delay = 1

Plug 'nvim-treesitter/nvim-treesitter'

Plug 'ryanoasis/vim-devicons'
Plug 'itchyny/lightline.vim'
let g:lightline = { 'colorscheme': 'wombat' }

Plug 'norcalli/nvim-colorizer.lua'

Plug 'crusoexia/vim-monokai'
let g:monokai_term_italic = 1
let g:monokai_gui_italic = 1
call plug#end()
endif
" }}}

" Basic Settings {{{

" Clipboard sanity
set pastetoggle=<F2>
set nopaste
set clipboard=unnamedplus
set mouse=a

" Line numbers
set number
set norelativenumber
set textwidth=0
set nowrap
set nofoldenable
set foldmethod=syntax
set foldnestmax=10

set nolist
set listchars=extends:#,precedes:#,tab:▸-
set fillchars=vert:│
set diffopt+=vertical,indent-heuristic,algorithm:patience

" set colorcolumn=80
set colorcolumn=

set showtabline=0 " do not disply tab on the top os the screen
set ruler         " disply line/col in status bar
set autoread

set startofline   " scrolling puts cursor on first non blank character
set scrolloff=15  " cursor margins

" search settings
set nohlsearch
set incsearch
set ignorecase
set smartcase
set inccommand=split

set tabstop=4
set softtabstop=4
set shiftwidth=4  " Indentation amount for < and > commands.
set shiftround
set expandtab     " Insert spaces when TAB is pressed.
set smartindent

set nosplitbelow
set splitright    " Vertical split to right of current.
set previewheight=20

" http://stackoverflow.com/questions/102384/using-vims-tabs-like-buffers
set hidden

" Enable persistent undo so that undo history persists across vim sessions
set undofile

set nobackup
set noswapfile

" Spelling
set spelllang=en_us

" tab completion in comand mode
set wildmode=longest:full,full
set wildmenu
set wildoptions=pum,tagfile
set wildignore+=*/.git/*,*.pyc,*.swp,*.o
set wildignorecase
set path+=**

set completeopt=menuone,noinsert,noselect

set noshowmode
set noshowcmd

set signcolumn=yes

" mainly for tagbar hilight
set updatetime=500

set shortmess+=Wc

set conceallevel=0

" }}}

" Key Mappings {{{

" bad habit
cnoremap <Left>   <nop>
cnoremap <Right>  <nop>
cnoremap <Up>     <nop>
cnoremap <Down>   <nop>

" more tmux like behavior
nnoremap <c-w>c :tabedit %<cr>

" update history on certain input events
" note: careful, this is not cool when using macro..
" if there was any way to make this enabled but not when recording macro..
inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>
inoremap <c-r> <c-g>u<c-r>
" inoremap <Space> <Space><c-g>u

vnoremap < <gv
vnoremap > >gv

" Visual linewise up and down by default (and use gj gk to go quicker)
noremap j gj
noremap k gk

cnoremap <c-n> <down>
cnoremap <c-p> <up>
cnoremap <c-a> <home>

" nnoremap <silent> <leader><leader> :nohlsearch<c-r>=has('diff')?'<bar>diffupdate':''<cr><cr><c-l>

nnoremap n nzt
nnoremap N Nzt
nnoremap * *zt
nnoremap # #zt
nnoremap g* g*zt
nnoremap g# g#zt
nnoremap <c-]> <c-]>zt
nnoremap <c-t> <c-t>zt
" nnoremap <c-i> <c-i>zt
" nnoremap <c-o> <c-o>zt
" nnoremap gd gdzt
nnoremap G Gzz

noremap <leader>ds :windo diffthis<cr>
noremap <leader>de :windo diffoff<cr>
noremap <leader>dd :Gdiffsplit<cr>
nnoremap <leader>z :let @z=expand("<cword>")<cr>q:i%s/\C\v<<esc>"zpa>//g<esc>hi
nnoremap <leader>e :e $MYVIMRC<cr>
" nnoremap <leader>e :e <c-R>=expand("%:p:h") . '/'<cr>

nnoremap <silent> <leader>q :botright copen 10<cr>
" nnoremap <silent> <leader>l :botright lopen 10<cr>

nmap <leader>W :%s/\s\+$//e<cr>

" }}}

" Custom misc functions {{{
" some functions to inspect colorscheme settings
function! SynStackFun()
  if !exists("*synstack")
  return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
command! SyntaxStack call SynStackFun()
command! FgColor :echo synIDattr(synIDtrans(synID(line("."), col("."), 1)), "fg")
command! BgColor :echo synIDattr(synIDtrans(synID(line("."), col("."), 1)), "bg")

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

" toggle xyz.py with test_xyz.py (in subdirectory of current root)
function! PytestFileToggle() abort
  let l:file = expand('%:t')
  if empty(file)
    return
  elseif l:file =~# '^test_.\+\.py$'
    let l:alt_file = substitute(l:file, '^test_', '', '')
  elseif l:file =~# '^.\+.py$'
    let l:alt_file = 'test_' . l:file
  else
    return
  endif
  if bufexists(alt_file)
    execute 'b ' . l:alt_file
  elseif filewritable('**/' . l:alt_file)
    execute 'e **/' . l:alt_file
  else
    execute 'e ' . expand('%:p:h') . '/' . l:alt_file
  endif
endfunction

" }}}

" Auto commands {{{
augroup filetype_settings
  au!
  au FileType html,xhtml,css setl ts=2 sts=2 sw=2
  au FileType yaml setl fdm=indent ts=2 sts=2 sw=2
  au FileType gitcommit setl spell comments=b:#
  au FileType vim setl fdm=marker ts=2 sts=2 sw=2
  au FileType go
    \  setl noet ts=4 sts=4 sw=4
    \| nmap <buffer> <c-g> :GoDeclsDir<cr>
    \| imap <buffer> <c-g> <esc>:<c-u>GoDeclsDir<cr>
    \| nmap <buffer> <leader>gb :<c-u>call <SID>build_go_files()<cr>
    \| nmap <buffer> <leader>gt  <Plug>(go-test)
    \| nmap <buffer> <leader>gr  <Plug>(go-run)
    \| nmap <buffer> <Leader>gd <Plug>(go-doc)
    \| nmap <buffer> <Leader>gc <Plug>(go-coverage-toggle)
    \| nmap <buffer> <Leader>gi <Plug>(go-info)
    \| nmap <buffer> <Leader>gl <Plug>(go-metalinter)
    \| nmap <buffer> <leader>gn <Plug>(go-referrers)
    \| nmap <buffer> <Leader>gv <Plug>(go-def-vertical)
    \| nmap <buffer> <Leader>gs <Plug>(go-def-split)
  au FileType go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
  au FileType go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
  au FileType go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
  au FileType go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
  au FileType haskell
    \  setl tags+=codex.tags;/
    \| setl ts=2 sts=2 sw=2
  au FileType c,cpp
    \  setl fdm=syntax cms=//%s
    \| setl path=.,/usr/lib/gcc/x86_64-linux-gnu/9/include,/usr/local/include,/usr/lib/gcc/x86_64-linux-gnu/9/include-fixed,/usr/include/x86_64-linux-gnu,/usr/include,**
    \| setl tags+=~/.tags/c.tags
  au FileType sql setl cms=--%s ts=2 sts=2 sw=2
  " au FileType asm setl
  au FileType python
    \  let b:delimitMate_nesting_quotes = ['"']
    \| let b:delimitMate_smart_quotes = '\%([a-eg-qs-zA-Z_]\|[^[:punct:][:space:]fr]\|\%(\\\\\)*\\\)\%#\|\%#\%(\w\|[^[:space:][:punct:]]\)'
  au FileType python command! -bang A call PytestFileToggle()
  au FileType markdown setl spell | let b:delimitMate_nesting_quotes = ['`']
  au FileType qf nnoremap <silent> <buffer> q :cclose<cr>:lclose<cr>
  au FileType help setl signcolumn=no | nnoremap <silent> <buffer> q :q<cr>
  au FileType cmake setl cms=#%s
  au FileType vifm setl syntax=vim cms=\"%s
  au FileType coq
    \  setl cms=(*%s*) ts=2 sts=2 sw=2
    \| nmap <buffer> <silent> <leader>cc :CoqLaunch<cr>
    \| nmap <buffer> <silent> <leader>cq :CoqKill<cr>
    \| nmap <buffer> <silent> <F5> :CoqToCursor<cr>
    \| nmap <buffer> <silent> <c-n> :CoqNext<cr>
    \| nmap <buffer> <silent> <c-p> :CoqUndo<cr>
    \| vmap <buffer> <silent> <c-n> :CoqNext<cr>
    \| vmap <buffer> <silent> <c-p> :CoqUndo<cr>
    \| imap <buffer> <silent> <c-n> <c-\><c-o>:CoqNext<cr>
    \| imap <buffer> <silent> <c-p> <c-\><c-o>:CoqUndo<cr>
  au FileType nerdtree,tagbar setl nonu signcolumn=no
augroup end

augroup particular_file_settings
  au!
  au BufRead */.zshrc set fdm=marker
  au BufRead */.aliases set filetype=sh
augroup end

augroup nosmartcase_cmd
  au!
  au CmdlineEnter * set nosmartcase
  au CmdlineLeave * set smartcase
augroup end

" smart number toggling
augroup smartnumbers
  au!
  au InsertEnter * if empty(&buftype) | setl nornu | endif
  au InsertLeave * if empty(&buftype) | setl rnu | endif
  au WinEnter,BufNewFile,BufReadPost * if empty(&buftype) | setl rnu | endif
  au WinLeave   * if empty(&buftype) | set rnu< | endif
augroup end

" Hilight the yanked region for a moment
au TextYankPost * silent! lua return (not vim.v.event.visual) and require'vim.highlight'.on_yank()

" terminal
function! TerminalSet()
  " let g:last_terminal_job_id = b:terminal_job_id
  setl nonu nornu signcolumn=no
  startinsert
  nnoremap <buffer> q i
  vnoremap <buffer> q <Esc>i
endfunction
augroup Terminal
  au!
  au TermOpen *  call TerminalSet()
  au BufWinEnter,WinEnter term://* startinsert
  au BufLeave term://* stopinsert
augroup end
tnoremap <silent> <a-\> <c-\><c-n>:TmuxNavigatePrevious<cr>
tnoremap <silent> <a-h> <c-\><c-N>:TmuxNavigateLeft<cr>
tnoremap <silent> <a-j> <c-\><c-N>:TmuxNavigateDown<cr>
tnoremap <silent> <a-k> <c-\><c-N>:TmuxNavigateUp<cr>
tnoremap <silent> <a-l> <c-\><c-N>:TmuxNavigateRight<cr>
" tnoremap <silent> <c-[> <c-\><c-n>0k
tnoremap <pageup> <c-\><c-n><pageup>
tnoremap <pagedown> <c-\><c-n><pagedown>
" nnoremap <silent> <leader>tb :botright split term://zsh<cr>
" nnoremap <silent> <leader>tv :vsplit term://zsh<cr>
" nnoremap <silent> <leader>ts :bel split term://zsh<cr>
" }}}

" Colors {{{
set termguicolors

hi MatchParen  cterm=underline ctermbg=0 gui=underline guibg=bg
function! ColorCustomizations()
  hi DiffAdd        guifg=#A6E22D  guibg=#2D2E27
  hi DiffChange     guifg=#d7d7ff  guibg=bg
  hi DiffDelete     guifg=#575b61  guibg=#2D2E27
  hi DiffText       guifg=#FD9720  guibg=#3d1c25

  hi diffAdded      guifg=#A6E22D ctermfg=DarkGreen
  hi diffRemoved    guifg=#F92772 ctermfg=DarkRed
  hi diffFile       guifg=#66D9EF ctermfg=White
  hi diffIndexLine  guifg=#66D9EF ctermfg=White
  hi diffLine       guifg=#66D9EF ctermfg=White
  hi diffSubname    guifg=White   ctermfg=White
  hi CheckedByCoq   guibg=#313337
  hi SentToCoq      guibg=#313337
endfunction
au ColorScheme * call ColorCustomizations()

silent! colorscheme monokai
" }}}

" LSP {{{
" call lsp#set_log_level("debug")
call sign_define("LspDiagnosticsErrorSign", {"text" : "✖", "texthl" : "LspDiagnosticsErrorSign"})
call sign_define("LspDiagnosticsWarningSign", {"text" : "⚠", "texthl" : "LspDiagnosticsWarningSign"})
call sign_define("LspDiagnosticInformationSign", {"text" : "ℹ", "texthl" : "LspDiagnosticsInformationSign"})
call sign_define("LspDiagnosticHintSign", {"text" : "💡", "texthl" : "LspDiagnosticsHintSign"})

exec 'hi LspDiagnosticsError ' .
        \' guifg=' . synIDattr(synIDtrans(hlID('SpellBad')), 'fg', 'gui') .
        \' ctermfg=' . synIDattr(synIDtrans(hlID('SpellBad')), 'fg', 'cterm')
exec 'hi LspDiagnosticsErrorSign ' .
        \' guifg=' . synIDattr(synIDtrans(hlID('SpellBad')), 'fg', 'gui') .
        \' ctermfg=' . synIDattr(synIDtrans(hlID('SpellBad')), 'fg', 'cterm')
        \' guibg=' . synIDattr(synIDtrans(hlID('SignColumn')), 'bg', 'gui') .
        \' ctermbg=' . synIDattr(synIDtrans(hlID('SignColumn')), 'bg', 'cterm')
exec 'hi LspDiagnosticsWarningSign ctermfg=208 guifg=#FD9720' .
        \' guibg=' . synIDattr(synIDtrans(hlID('SignColumn')), 'bg', 'gui') .
        \' ctermbg=' . synIDattr(synIDtrans(hlID('SignColumn')), 'bg', 'cterm')
hi link LspDiagnosticInformationSign LspDiagnosticsWarningSign
hi link LspDiagnosticHintSign LspDiagnosticsWarningSign
hi link LspReferenceText CursorLine
hi LspDiagnosticsUnderline cterm=None gui=None

nnoremap <silent><a-d> <cmd>lua vim.lsp.util.show_line_diagnostics()<cr>

augroup LSP
  au!
  au Filetype rust,python,c,cpp,lua,tex,sh,bash
    \  setl omnifunc=v:lua.vim.lsp.omnifunc
    \| nnoremap <silent><c-t> <c-o>zt
    \| inoremap <silent><a-s>     <cmd>lua vim.lsp.buf.signature_help()<cr>
    \| nnoremap <silent>K         <cmd>lua vim.lsp.buf.hover()<cr>
    \| nnoremap <silent><leader>n <cmd>lua vim.lsp.buf.references()<cr>
    \| nnoremap <silent><leader>r <cmd>lua vim.lsp.buf.rename()<cr>
    \| nnoremap <silent><leader>= <cmd>lua vim.lsp.buf.formatting()<cr>
    \| vnoremap <silent><leader>= <esc><cmd>lua vim.lsp.buf.range_formatting()<cr>
    \| nnoremap <silent>g0 <cmd>lua vim.lsp.buf.document_symbol()<cr>
  au Filetype python,lua
    \ nnoremap <silent><c-]> <cmd>lua vim.lsp.buf.definition()<cr>zt
  au Filetype c,cpp,rust
    \  nnoremap <silent>gd <cmd>lua vim.lsp.buf.declaration()<cr>zt
    \| nnoremap <silent><c-]> <cmd>lua vim.lsp.buf.definition()<cr>zt
    \| nnoremap <silent>gD <cmd>lua vim.lsp.buf.implementation()<cr>zt
  " au CursorHold <buffer> lua vim.lsp.buf.document_highlight()
  " au CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
  " au CursorMoved <buffer> lua vim.lsp.buf.clear_references()
augroup end
" }}}

lua require('linit')
