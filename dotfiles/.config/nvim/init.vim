" neovim-npython installations
let g:python_host_prog = $PYTHON2_NVIM_VIRTUALENV
let g:python3_host_prog = $PYTHON3_NVIM_VIRTUALENV

let mapleader=","

" Plugins {{{
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
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gd :Gdiff<cr>
nnoremap <leader>gb :Gblame<cr>
nnoremap <leader>gw :Gwrite
Plug 'tpope/vim-rhubarb'   " gihtub Gitbrowse
Plug 'tommcdo/vim-fubitive'  " bitbucket Gbrowse
Plug 'tpope/vim-unimpaired'  " Handy bracket mappings
Plug 'tpope/vim-sleuth'    " guess ts heuristically
let g:sleuth_automatic=0
" Plug 'tpope/vim-abolish'    " substitute imrpoved
Plug 'christoomey/vim-tmux-navigator'
let g:tmux_navigator_disable_when_zoomed = 1

" Auto save on every escape
Plug '907th/vim-auto-save'
let g:auto_save = 1
let g:auto_save_in_insert_mode = 0
let g:auto_save_silent = 1

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
let g:fzf_command_prefix = 'Fzf'
Plug 'pbogut/fzf-mru.vim'
Plug 'rking/ag.vim'
nnoremap <leader>p :FzfFiles<cr>
nnoremap <leader>P :FzfCommands<cr>
nnoremap <leader>b :FzfBuffer<cr>
nnoremap <leader>m :FZFMru<cr>

Plug 'easymotion/vim-easymotion'
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
nmap t  <Plug>(easymotion-s2)
vmap tk <Plug>(easymotion-k)
vmap tj <Plug>(easymotion-j)
vmap th <Plug>(easymotion-linebackward)
vmap tl <Plug>(easymotion-lineforward)

Plug 'haya14busa/incsearch.vim'
let g:incsearch#auto_nohlsearch = 1
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
map n  <Plug>(incsearch-nohl-n)zt
map N  <Plug>(incsearch-nohl-N)zt
map *  <Plug>(incsearch-nohl-*)zt
map #  <Plug>(incsearch-nohl-#)zt
map g* <Plug>(incsearch-nohl-g*)zt
map g# <Plug>(incsearch-nohl-g#)zt

" Hilight the yanked region for a moment
Plug 'machakann/vim-highlightedyank'

" This should improve highlight while find/replace
" Plug 'osyo-manga/vim-over'

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

" Plug 'Shougo/echodoc.vim' " Print function signature
" let g:echodoc#enable_at_startup = 1
Plug 'Shougo/vinarise.vim' " hex editor

" Various text objects
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-line' " l
Plug 'mattn/vim-textobj-url' " u

Plug 'vim-scripts/ReplaceWithRegister'  " gr gx
Plug 'christoomey/vim-sort-motion'    " gs
Plug 'AndrewRadev/splitjoin.vim'    " gJ gS

Plug 'tyru/open-browser.vim'
nnoremap gx <Plug>(openbrowser-smart-search)
vnoremap gx <Plug>(openbrowser-smart-search)

Plug 'scrooloose/nerdcommenter'
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDCreateDefaultMappings = 0
nnoremap <C-_>    <Plug>NERDCommenterToggle
nnoremap <C-g>cc  <Plug>NERDCommenterAppend
xnoremap <C-g>cc  <Plug>NERDCommenterSexy
xnoremap <c-g>cu  <Plug>NERDComUncommentLine

Plug 'airblade/vim-gitgutter' " show git changes
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

" Intelligently toggling line numbers
" todo: fix nvim terminal
Plug 'myusuf3/numbers.vim'

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
" Plug 'Yggdroot/indentLine'
" Plug 'kien/rainbow_parentheses.vim'

" Panel with tags
Plug 'majutsushi/tagbar'
let g:tagbar_autoclose=1
nnoremap <A-e> :TagbarToggle<cr>

Plug 'mbbill/undotree'
nnoremap <leader>u :UndotreeToggle<cr>

Plug 'neomake/neomake'      " async linter
let g:neomake_verbose=0
let g:neomake_rust_cargo_command = ['test', '--no-run']
let g:neomake_c_enabled_makers = ['clangcheck']

" Snippets
Plug 'SirVer/ultisnips'
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
Plug 'honza/vim-snippets'

" Autocompletion engine
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#ignore_sources = {}
let g:deoplete#ignore_sources.python = ['around']
let g:deoplete#ignore_sources.c = ['around']
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return deoplete#mappings#close_popup() . "\<CR>"
endfunction

Plug 'zchee/deoplete-jedi'
Plug 'zchee/deoplete-go'
Plug 'zchee/deoplete-zsh'
Plug 'zchee/deoplete-clang'
let g:deoplete#sources#clang#libclang_path = '/usr/lib/llvm-3.8/lib/libclang.so.1'
let g:deoplete#sources#clang#clang_header = '/usr/lib/llvm-3.8/lib/clang/'
let g:deoplete#sources#clang#sort_algo = 'priority'
Plug 'sebastianmarkow/deoplete-rust'
Plug 'Shougo/neco-vim'

" Autoformat
Plug 'sbdchd/neoformat'
let g:neoformat_basic_format_trim = 1
let g:neoformat_basic_format_retab = 1
let g:neoformat_only_msg_on_error = 1
let g:neoformat_run_all_formatters = 1
let g:neoformat_enabled_python = ['yapf', 'isort']
let g:neoformat_enabled_go = ['goimports']
let g:neoformat_enabled_c = ['clangformat']
nnoremap <leader>o :Neoformat<cr>

" Python
Plug 'davidhalter/jedi-vim',          { 'for': ['python', 'python3']}
let g:jedi#completions_enabled = 0
let g:jedi#show_call_signatures = 0
let g:jedi#goto_command = "<C-]>"
Plug 'jmcantrell/vim-virtualenv',     { 'for': ['python', 'python3']}
Plug 'tmhedberg/SimpylFold',          { 'for': ['python', 'python3']}
Plug 'bfredl/nvim-ipy'

" C/C++
" switch to/from heade file
Plug 'vim-scripts/a.vim',             { 'for': ['c', 'cpp']}
" Plug 'vim-scripts/c.vim',           { 'for': ['c', 'cpp']}

" Haskell
Plug 'Shougo/vimproc.vim',            { 'do' : 'make'}
Plug 'neovimhaskell/haskell-vim',     { 'for': 'haskell' }
Plug 'eagletmt/ghcmod-vim',           { 'for': 'haskell' }
Plug 'eagletmt/neco-ghc',             { 'for': 'haskell' }
Plug 'Twinside/vim-hoogle',           { 'for': 'haskell' }
Plug 'mpickering/hlint-refactor-vim', { 'for': 'haskell' }


Plug 'fatih/vim-go',                  { 'for': 'go' }
Plug 'pangloss/vim-javascript',       { 'for': 'javascript' }
Plug 'lervag/vimtex',                 { 'for': 'latex' }
Plug 'rust-lang/rust.vim',            { 'for': 'rust' }
" Plug 'vim-ruby/vim-ruby'

Plug 'plasticboy/vim-markdown'
Plug 'elzr/vim-json'
Plug 'stephpy/vim-yaml'
Plug 'glench/vim-jinja2-syntax'
Plug 'mfukar/robotframework-vim'
Plug 'roalddevries/yaml.vim'
Plug 'ekalinin/dockerfile.vim'
Plug 'ClockworkNet/vim-junos-syntax'

Plug 'vim-airline/vim-airline'
let g:airline_powerline_fonts = 1
let g:airline_exclude_preview = 1
let g:airline_detect_spell=0
let g:airline_detect_spelllang=0
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
let g:airline_section_y=""
let g:airline_section_z='%4l,%3v'
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline#extensions#tagbar#enabled = 0
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'

" Color themes
Plug 'frankier/neovim-colors-solarized-truecolor-only'
Plug 'crusoexia/vim-monokai'
Plug 'morhetz/gruvbox'
Plug 'joshdick/onedark.vim'
call plug#end()
" }}}

" Basic Settings {{{

syntax enable

" Clipboard sanity
set pastetoggle=<F2>
set nopaste
set clipboard=unnamedplus
set mouse=a

" Line numbers
set number
set relativenumber
set textwidth=0
set nowrap
set nofoldenable
set foldmethod=syntax
set foldnestmax=10

set nolist
set listchars=extends:#,precedes:#,tab:▸-
set fillchars=vert:│
set diffopt+=vertical

" set colorcolumn=80
set colorcolumn=

set showtabline=0 " do not disply tab on the top os the screen
set ruler     " disply line/col in status bar
set autoread

" Enable persistent undo so that undo history persists across vim sessions
set undofile

set startofline   " scrolling puts cursor on first non blank character
set scrolloff=15  " cursor margins

" search settings
set hlsearch
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

set nobackup
set noswapfile

" Spelling
set spelllang=en_us

" tab completion
set wildmode=longest:full,list:full
set wildmenu
set wildignore+=*/.git/*,*.pyc,*.swp,*.o
set path+=**

set completeopt=menuone,longest

set noshowmode
set showcmd

if executable('rg')
  set grepprg=rg\ --color=never
endif

" }}}

" Key Mappings {{{

" bad habit
cnoremap <Left>   <nop>
cnoremap <Right>  <nop>
cnoremap <Up>     <nop>
cnoremap <Down>   <nop>

" more tmux like behavior
nnoremap <C-w>c :tabedit %<cr>

" update history on certain input events
" note: careful, this is not cool when using macro..
" if there was any way to make this enabled but not when recording macro..
inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>
inoremap <c-r> <c-g>u<c-r>
" inoremap <Space> <Space><C-g>u

vnoremap < <gv
vnoremap > >gv

" Visual linewise up and down by default (and use gj gk to go quicker)
noremap j gj
noremap k gk

cnoremap <c-n> <down>
cnoremap <c-p> <up>
cnoremap <c-a> <home>

nnoremap <silent> <leader><leader> :nohlsearch<c-r>=has('diff')?'<bar>diffupdate':''<cr><cr><c-l>

" Highlight all instances of word under cursor, when idle.
" Useful when studying strange source code.
" Type z/ to toggle highlighting on/off.
" http://vim.wikia.com/wiki/VimTip572
nnoremap z/ :if AutoHighlightToggle()<Bar>set hls<Bar>endif<cr>
function! AutoHighlightToggle()
  let @/ = ''
  if exists('#auto_highlight')
    au! auto_highlight
    augroup! auto_highlight
    setl updatetime=4000
    echo 'Highlight current word: off'
    return 0
  else
    augroup auto_highlight
      au!
      au CursorHold * let @/ = '\V\<'.escape(expand('<cword>'), '\').'\>'
    augroup end
    setl updatetime=500
    echo 'Highlight current word: ON'
    return 1
  endif
endfunction

nmap <c-]> <c-]>zt
nmap <c-t> <c-t>zt
nmap <c-i> <c-i>zt
nmap <c-o> <c-o>zt
nmap gd gdzt

noremap <leader>ds :windo diffon<cr>
noremap <leader>de :windo diffoff<cr>
nnoremap <leader>z :let @z=expand("<cword>")<cr>q:i%s/\C\v<<esc>"zpa>//g<esc>hi
nnoremap <leader>s :set spell!<cr>
nnoremap <leader>l :set list!<cr>
nnoremap <leader>e :e $MYVIMRC<cr>
" nnoremap <leader>e :e <C-R>=expand("%:p:h") . '/'<cr>

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

" https://github.com/clvv/fasd/wiki/Vim-Integration
command! -nargs=* J :call J(<f-args>)
function! J(...)
  let cmd = 'fasd -d -e printf'
  for arg in a:000
  let cmd = cmd . ' ' . arg
  endfor
  let path = system(cmd)
  if isdirectory(path)
  echo path
  exec 'cd' fnameescape(path)
  endif
endfunctio
" }}}

" Auto commands {{{
augroup filetype_settings
  au!
  au FileType html setl ts=2 sts=2 sw=2 
  au FileType yaml setl fdm=indent ts=2 sts=2 sw=2
  au FileType gitcommit setl spell
  au FileType vim setl fdm=marker ts=2 sts=2 sw=2
  " au FileType go
  " au FileType haskell
  au FileType python let b:delimitMate_nesting_quotes = ['"']
  au FileType qf nnoremap <silent> <buffer> q :cclose<cr>:lclose<cr>
  au FileType help nnoremap <silent> <buffer> q :q<cr>
augroup end

" Remove trailing whitespace on file save
" autocmd BufWritePre * :%s/\s\+$//e

" run lint on save
call neomake#configure#automake('rw', 750)

" terminal
if has('nvim')
  augroup Terminal
    au!
    au TermOpen * let g:last_terminal_job_id = b:terminal_job_id
    au WinEnter term://* startinsert
  augroup END
  tnoremap <c-\><c-\> <c-\><c-n><c-w><c-w>
  " c-w is not good prefix as it breakes instant c-w in fzf
  " tnoremap <c-w>j <c-\><c-n><c-w>j
  " tnoremap <c-w>k <c-\><c-n><c-w>k
  " tnoremap <c-w>h <c-\><c-n><c-w>h
  " tnoremap <c-w>l <c-\><c-n><c-w>l
  " tnoremap <silent> <c-w>z <c-\><c-n>:ZoomWinTabToggle<cr>
  tnoremap <pageup> <c-\><c-n><pageup>
  tnoremap <pagedown> <c-\><c-n><pagedown>
  " https://github.com/neovim/neovim/issues/2897#issuecomment-115464516
  let g:terminal_color_0  = '#2e3436'
  let g:terminal_color_1  = '#cc0000'
  let g:terminal_color_2  = '#4e9a06'
  let g:terminal_color_3  = '#c4a000'
  let g:terminal_color_4  = '#3465a4'
  let g:terminal_color_5  = '#75507b'
  let g:terminal_color_6  = '#0b939b'
  let g:terminal_color_7  = '#d3d7cf'
  let g:terminal_color_8  = '#555753'
  let g:terminal_color_9  = '#ef2929'
  let g:terminal_color_10 = '#8ae234'
  let g:terminal_color_11 = '#fce94f'
  let g:terminal_color_12 = '#729fcf'
  let g:terminal_color_13 = '#ad7fa8'
  let g:terminal_color_14 = '#00f5e9'
  let g:terminal_color_15 = '#eeeeec'
endif

" }}}

" Colors {{{

function! ColorCustomizations()
  hi MatchParen  guifg=none     guibg=none  gui=underline
  hi DiffAdd     guifg=#A6E22D  guibg=#2D2E27
  hi DiffChange  guifg=#d7d7ff  guibg=bg
  hi DiffDelete  guifg=#575b61  guibg=#2D2E27
  hi DiffText    guifg=#FD9720  guibg=#2D2E27
endfunction
au ColorScheme * call ColorCustomizations()

set termguicolors

set background=dark
" silent! colorscheme onedark
silent! colorscheme monokai
" silent! colorscheme gruvbox

" silent! colorscheme solarized
" set background=light
" hilight matching parenthesis style
" }}}
