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

Plug 'tpope/vim-sensible'
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

" allow to open file:line from terminal
Plug 'bogado/file-line'

" Auto save on every escape
Plug '907th/vim-auto-save'
let g:auto_save = 1
let g:auto_save_in_insert_mode = 0
let g:auto_save_silent = 1

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
let g:fzf_command_prefix = 'Fzf'
Plug 'pbogut/fzf-mru.vim'
nnoremap <leader>p :FzfFiles<cr>
nnoremap <leader>P :FzfCommands<cr>
nnoremap <leader>b :FzfBuffer<cr>
nnoremap <leader>m :FZFMru<cr>

Plug 'mileszs/ack.vim'
if executable('rg')
  let g:ackprg = 'rg --vimgrep'
  set grepprg=rg\ --vimgrep
  set grepformat=%f:%l:%c:%m
  cnoreabbrev Rg Ack
elseif executable('ag')
  let g:ackprg = 'ag --vimgrep'
  set grepprg=ag\ --vimgrep
  set grepformat=%f:%l:%c:%m
  cnoreabbrev Ag Ack
endif

Plug 'easymotion/vim-easymotion'
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
nmap t  <Plug>(easymotion-s2)
vmap tk <Plug>(easymotion-k)
vmap tj <Plug>(easymotion-j)
vmap th <Plug>(easymotion-linebackward)
vmap tl <Plug>(easymotion-lineforward)

" Hilight the yanked region for a moment
Plug 'machakann/vim-highlightedyank'

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

Plug 'vim-scripts/ReplaceWithRegister' " gr gx
Plug 'christoomey/vim-sort-motion'     " gs
Plug 'AndrewRadev/splitjoin.vim'       " gJ gS

Plug 'tyru/open-browser.vim'
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

" Plug 'scrooloose/nerdcommenter'
" let g:NERDSpaceDelims = 1
" let g:NERDCompactSexyComs = 1
" let g:NERDDefaultAlign = 'left'
" let g:NERDCommentEmptyLines = 1
" let g:NERDTrimTrailingWhitespace = 1
" let g:NERDCreateDefaultMappings = 0
" let g:NERDAltDelims_c = 1
" nmap <c-_>    <Plug>NERDCommenterToggle
" nmap <c-g>cc  <Plug>NERDCommenterAppend
" xmap <c-g>cc  <Plug>NERDCommenterSexy
" xmap <c-g>cu  <Plug>NERDComUncommentLine

Plug 'airblade/vim-gitgutter' " show git changes
let g:gitgutter_map_keys = 0
nmap [c <Plug>GitGutterPrevHunkzt
nmap ]c <Plug>GitGutterNextHunkzt

Plug 'kshenoy/vim-signature'  " show marks

" Nice left panel with tree structured files
Plug 'scrooloose/nerdtree'
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeHighlightCursorline=1
let g:NERDTreeWinSize=50
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
map <leader>Bd :Bdelete<cr>
map <leader>BD :bdelete<cr>

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

" Plug 'embear/vim-localvimrc'

" Eclipse like autoopening of quotes/parenthesis
Plug 'raimondi/delimitmate'
let g:delimitMate_expand_cr = 1

" Hilight/remove trailing whitespaces
" Plug 'ntpeters/vim-better-whitespace'

" Plug 'kien/rainbow_parentheses.vim'
Plug 'RRethy/vim-illuminate'

" Panel with tags
Plug 'majutsushi/tagbar'
let g:tagbar_autoclose=1
let g:tagbar_sort = 0
nnoremap <a-e> :TagbarToggle<cr>
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

Plug 'neomake/neomake'      " async linter
let g:neomake_virtualtext_current_error = 0
let g:neomake_verbose = 0
let g:neomake_rust_cargo_command = ['test', '--no-run']
let g:neomake_c_enabled_makers = ['clangcheck']
let g:neomake_python_enabled_makers = ['flake8']
let g:neomake_haskell_ghc_mod_args = '-g-Wall'

" Snippets
if has('python')
  Plug 'SirVer/ultisnips'
  let g:UltiSnipsEditSplit="vertical"
  let g:UltiSnipsExpandTrigger="<tab>"
  let g:UltiSnipsJumpForwardTrigger="<tab>"
  let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
  Plug 'honza/vim-snippets'
endif

" Autoformat
Plug 'sbdchd/neoformat'
let g:neoformat_basic_format_trim = 1
let g:neoformat_basic_format_retab = 1
let g:neoformat_only_msg_on_error = 1
let g:neoformat_run_all_formatters = 1
let g:neoformat_enabled_python = ['yapf', 'isort']
let g:neoformat_enabled_go = ['goimports']
let g:neoformat_enabled_c = ['clangformat']
let g:neoformat_enabled_haskell = ['hindent']
let g:neoformat_enabled_javascript = ['jsbeautify']
nnoremap <leader>o :Neoformat<cr>

" Python
Plug 'Vimjas/vim-python-pep8-indent', { 'for': ['python', 'python3']}
Plug 'davidhalter/jedi-vim',          { 'for': ['python', 'python3']}
let g:jedi#completions_enabled = 0
let g:jedi#show_call_signatures = 1
let g:jedi#goto_command = "<c-]>"
Plug 'tmhedberg/SimpylFold',          { 'for': ['python', 'python3']}
Plug 'bfredl/nvim-ipy',             { 'do': ':UpdateRemotePlugins' }
Plug 'BurningEther/iron.nvim',      { 'do': ':UpdateRemotePlugins' }

" C/C++
" switch to/from heade file with :A
Plug 'vim-scripts/a.vim',             { 'for': ['c', 'cpp']}
Plug 'justinmk/vim-syntax-extra'

" Haskell
Plug 'Shougo/vimproc.vim',            { 'do' : 'make'}
Plug 'neovimhaskell/haskell-vim',     { 'for': 'haskell' }
Plug 'eagletmt/ghcmod-vim',           { 'for': 'haskell' }
let g:necoghc_use_stack = 1
let g:necoghc_enable_detailed_browse = 1
Plug 'Twinside/vim-hoogle',           { 'for': 'haskell' }
let g:hoogle_search_jump_back = 0
Plug 'mpickering/hlint-refactor-vim', { 'for': 'haskell' }
let g:hlintRefactor#disableDefaultKeybindings = 1

Plug 'fatih/vim-go',                  { 'for': 'go' }
let g:go_fmt_autosave = 0
let g:go_term_mode = 'split'
let g:go_term_enabled = 1
let g:go_fmt_command = "goimports"
let g:go_autodetect_gopath = 1
let g:go_list_type = 'quickfix'
let g:go_bin_path = $HOME.'/.local/bin'
" let g:go_auto_type_info = 1
" let g:go_auto_sameids = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_generate_tags = 1
Plug 'jalvesaq/Nvim-R',               { 'for': 'r' }
Plug 'pangloss/vim-javascript',       { 'for': 'javascript' }
Plug 'lervag/vimtex',                 { 'for': 'tex' }
let g:tex_flavor='latex'
let g:vimtex_compiler_progname = 'nvr'

Plug 'rust-lang/rust.vim',            { 'for': 'rust' }
Plug 'racer-rust/vim-racer',          { 'for': 'rust' }
let g:racer_experimental_completer = 1

" Plug 'vim-ruby/vim-ruby',            { 'for': 'ruby' }

Plug 'plasticboy/vim-markdown',       { 'for' : 'markdown' }
function! BuildComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    !cargo build --release
  endif
endfunction
Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }
let g:markdown_composer_open_browser = 0
if executable('qutebrowser')
  let g:markdown_composer_browser = "qutebrowser --target window"
endif

Plug 'elzr/vim-json',                 { 'for' : 'json' }
Plug 'stephpy/vim-yaml',              { 'for' : 'vim' }
Plug 'glench/vim-jinja2-syntax',      { 'for' : 'jinja' }
Plug 'mfukar/robotframework-vim',     { 'for' : 'robot' }
Plug 'roalddevries/yaml.vim',         { 'for' : 'yaml' }
Plug 'ekalinin/dockerfile.vim',       { 'for' : 'Dockerfile' }
Plug 'momota/junos.vim',              { 'for' : 'junos' }
Plug 'let-def/vimbufsync'
Plug 'the-lambda-church/coquille',    { 'branch' : 'pathogen-bundle' }

" Autocompletion engine
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#ignore_sources = {}
let g:deoplete#ignore_sources.python = ['around']
let g:deoplete#ignore_sources.c = ['around', 'buffer', 'tag']
" timeout for numpy cache
let g:deoplete#sources#jedi#server_timeout=60

" this conflicts with delimitmate expand_cr
" inoremap <silent> <cr> <c-r>=<SID>my_cr_function()<cr>
" function! s:my_cr_function()
"   return deoplete#mappings#close_popup() . "\<cr>"
" endfunction
Plug 'zchee/deoplete-jedi',           { 'for': ['python', 'python3']}
Plug 'zchee/deoplete-go',             { 'for': 'go' }
Plug 'zchee/deoplete-zsh',            { 'for': 'zsh' }
Plug 'Shougo/deoplete-clangx',         { 'for': ['c', 'cpp']}
let g:deoplete#sources#clang#libclang_path = '/usr/lib/llvm-6.0/lib/libclang.so'
let g:deoplete#sources#clang#clang_header = '/usr/lib/llvm-6.0/lib/clang/'
let g:deoplete#sources#clang#sort_algo = 'priority'
Plug 'Shougo/neco-vim',               { 'for': 'vim' }
Plug 'eagletmt/neco-ghc',             { 'for': 'haskell' }


Plug 'vim-airline/vim-airline'
let g:airline_powerline_fonts = 1
let g:airline_exclude_preview = 1
let g:airline_detect_spell=0
let g:airline_detect_spelllang=0
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
let g:airline_section_y=""
let g:airline_section_z='%3P %4l,%3v'
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline#extensions#tagbar#enabled = 0
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'

Plug 'crusoexia/vim-monokai'
call plug#end()
" }}}
endif

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
set ruler     " disply line/col in status bar
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
set expandtab   " Insert spaces when TAB is pressed.
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

if has('cscope') && executable('cscope')
  set cscopetag cscopeverbose
  if has('quickfix')
    set cscopequickfix=s-,c-,d-,i-,t-,e-
  endif
  if filereadable("cscope.out")
    silent cs add cscope.out
  elseif $CSCOPE_DB != ""
    silent cs add $CSCOPE_DB
  endif
endif

set completeopt=menuone,longest

set noshowmode
set showcmd

set signcolumn=yes

" mainly for tagbar hilight
set updatetime=1000

set shortmess+=cW

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
nnoremap <c-i> <c-i>zt
nnoremap <c-o> <c-o>zt
nnoremap gd gdzt
nnoremap G Gzz

noremap <leader>ds :windo diffthis<cr>
noremap <leader>de :windo diffoff<cr>
noremap <leader>dd :Gdiffsplit<cr>
nnoremap <leader>z :let @z=expand("<cword>")<cr>q:i%s/\C\v<<esc>"zpa>//g<esc>hi
nnoremap <leader>e :e $MYVIMRC<cr>
" nnoremap <leader>e :e <c-R>=expand("%:p:h") . '/'<cr>

nnoremap <silent> <leader>q :botright copen 10<cr>
nnoremap <silent> <leader>l :botright lopen 10<cr>

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

function! ConfigIron()
lua << EOF
    iron = require("iron")
    iron.core.set_config {
        preferred = {
            python = "ipython"
        },
        repl_open_cmd = "vsplit"
    }
EOF
endfunction
silent! call ConfigIron()

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
    \| nmap <buffer> <leader>hc :GhcModCheckAndLintAsync<cr>
    \| nmap <buffer> <leader>hr :call ApplyOneSuggestion()<cr>
    \| nmap <buffer> <leader>hR :call ApplyAllSuggestions()<cr>
    \| nmap <buffer> <leader>ht :GhcModType<cr>
    \| nmap <buffer> <leader>hT :GhcModTypeInsert<cr>
    \| nmap <buffer> <leader>hh :Hoogle<cr>
    \| nmap <buffer> <leader>hH :Hoogle
    \| nmap <buffer> <leader>hi :HoogleInfo<cr>
    \| nmap <buffer> <leader>hI :HoogleInfo
    \| nmap <buffer> <leader><leader> :GhcModTypeClear<cr>:nohl<cr>
    \| nmap <buffer> <leader>hc :GhcModCheckAndLintAsync<cr>
    \| nmap <buffer> <leader>hl :Neomake hlint<cr>
  au FileType c,cpp
    \  setl fdm=syntax cms=//%s
    \| setl path=.,/usr/lib/gcc/x86_64-linux-gnu/7/include,/usr/local/include,/usr/lib/gcc/x86_64-linux-gnu/7/include-fixed,/usr/include/x86_64-linux-gnu,/usr/include,**
    \| setl tags+=~/.tags/c.tags
    \| nmap <buffer> <c-\>s :cs find s <c-R>=expand("<cword>")<cr><cr>
    \| nmap <buffer> <c-\>g :cs find g <c-R>=expand("<cword>")<cr><cr>
    \| nmap <buffer> <c-\>c :cs find c <c-R>=expand("<cword>")<cr><cr>
    \| nmap <buffer> <c-\>t :cs find t <c-R>=expand("<cword>")<cr><cr>
    \| nmap <buffer> <c-\>e :cs find e <c-R>=expand("<cword>")<cr><cr>
    \| nmap <buffer> <c-\>f :cs find f <c-R>=expand("<cfile>")<cr><cr>
    \| nmap <buffer> <c-\>i :cs find i ^<c-R>=expand("<cfile>")<cr>$<cr>
    \| nmap <buffer> <c-\>d :cs find d <c-R>=expand("<cword>")<cr><cr>
  au FileType rust
    \  setl tags=./rusty-tags.vi;/,$RUST_SRC_PATH/rusty-tags.vi
    \| nmap K <Plug>(rust-doc)
    \| nmap gd <Plug>(rust-def)
  au FileType sql setl cms=--%s ts=2 sts=2 sw=2
  " au FileType asm setl
  au FileType python
    \  let b:delimitMate_nesting_quotes = ['"']
    \| let b:delimitMate_smart_quotes = '\%([a-eg-qs-zA-Z_]\|[^[:punct:][:space:]fr]\|\%(\\\\\)*\\\)\%#\|\%#\%(\w\|[^[:space:][:punct:]]\)'
    \| nmap <buffer> <F5> ctril
    \| vmap <buffer> <F5> <Plug>(iron-send-motion)
    \| nmap <buffer> <F8> <Plug>(iron-interrupt)
  au FileType markdown setl spell | let b:delimitMate_nesting_quotes = ['`']
  au FileType qf nnoremap <silent> <buffer> q :cclose<cr>:lclose<cr>
  au FileType help setl signcolumn=no | nnoremap <silent> <buffer> q :q<cr>
  au FileType cmake setl cms=#%s
  au FileType tex
    \  if !exists('g:deoplete#omni#input_patterns')
    \|   let g:deoplete#omni#input_patterns = {}
    \| endif
    \| let g:deoplete#omni#input_patterns.tex = g:vimtex#re#deoplete
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
augroup end

augroup particular_file_settings
  au!
  autocmd BufRead */.zshrc set fdm=marker
augroup end

" Remove trailing whitespace on file save
" augroup prewrite
"   au!
"   au BufWritePre * :%s/\s\+$//e
" augroup end

" run lint on save
silent! call neomake#configure#automake('rw', 750)

" smart number toggling
augroup smartnumbers
  au!
  au InsertEnter * if empty(&buftype) | setl nornu | endif
  au InsertLeave * if empty(&buftype) | setl rnu | endif
  au WinEnter,BufNewFile,BufReadPost * if empty(&buftype) | setl rnu | endif
  au WinLeave   * if empty(&buftype) | set rnu< | endif
augroup end

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
augroup END
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

" https://github.com/neovim/neovim/issues/2897#issuecomment-115464516
let g:terminal_color_0  = '#272822'
let g:terminal_color_1  = '#f92672'
let g:terminal_color_2  = '#a6e22e'
let g:terminal_color_3  = '#f4bf75'
let g:terminal_color_4  = '#66d9ef'
let g:terminal_color_5  = '#ae81ff'
let g:terminal_color_6  = '#a1efe4'
let g:terminal_color_7  = '#f8f8f2'
let g:terminal_color_8  = '#666666'
let g:terminal_color_9  = '#ff3334'
let g:terminal_color_10 = '#9ec400'
let g:terminal_color_11 = '#e7c547'
let g:terminal_color_12 = '#7aa6da'
let g:terminal_color_13 = '#b77ee0'
let g:terminal_color_14 = '#54ced6'
let g:terminal_color_15 = '#ffffff'
" }}}

" Colors {{{
set termguicolors
set background=dark

hi MatchParen  cterm=underline ctermbg=0 gui=underline guibg=bg
function! ColorCustomizations()
  hi DiffAdd        guifg=#A6E22D  guibg=#2D2E27
  hi DiffChange     guifg=#d7d7ff  guibg=bg
  hi DiffDelete     guifg=#575b61  guibg=#2D2E27
  hi DiffText       guifg=#FD9720  guibg=#3d1c25

  hi diffAdded      guifg=#A6E22D ctermfg=DarkGreen
  hi diffRemoved    guifg=#66d9ef ctermfg=DarkRed
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
