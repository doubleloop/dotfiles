" neovim-npython installations
let g:python_host_prog = $PYTHON2_NVIM_VIRTUALENV
let g:python3_host_prog = $PYTHON3_NVIM_VIRTUALENV

" Basic Settings {{{

syntax enable

" Clipboard sanity
set pastetoggle=<F2>
set nopaste
set clipboard=unnamedplus

" Line numbers
set number
set relativenumber
set textwidth=0
set nowrap
set nofoldenable
set foldmethod=syntax

set nolist
set listchars=extends:#,precedes:#,tab:▸-

set diffopt+=vertical

" set colorcolumn=80
set colorcolumn=

set showcmd
set showtabline=0   " do not disply tab on the top os the screen
set ruler           " disply line/col in status bar
set autoread

" Enable persistent undo so that undo history persists across vim sessions
set undofile

" disable - as word separator
" set iskeyword+=-

" commands that can go to next line (added bs and space)
set whichwrap=<,>,[,],b,s

set startofline     " scrolling puts cursor on first non blank character
set scrolloff=15            " cursor margins

" search settings
set hlsearch
set incsearch
set ignorecase
set inccommand=split

set tabstop=4
set softtabstop=4
set shiftwidth=4    " Indentation amount for < and > commands.
set shiftround
set expandtab       " Insert spaces when TAB is pressed.
set smartindent

set nosplitbelow
set splitright      " Vertical split to right of current.
set previewheight=20

" http://stackoverflow.com/questions/102384/using-vims-tabs-like-buffers
set hidden

set nobackup
set noswapfile

" Spelling
set spelllang=en_us

" tab completion
set wildmode=longest,full
set wildmenu
set wildignore+=*.pyc,*/.git/*,*.swp,*.o

set completeopt=menuone,longest,noselect
set noshowmode
set path+=**
set fileignorecase

if executable('rg')
  set grepprg=rg\ --color=never
  let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
  let g:ctrlp_use_caching = 0
endif

" }}}

" Plugins {{{
call plug#begin('~/.local/share/nvim/plugged')

" Better vim in terminal
Plug 'wincent/terminus'
Plug 'danro/rename.vim'
" Sane pane navigation shortcuts
Plug 'christoomey/vim-tmux-navigator'

" Auto save on every escape
Plug 'vim-scripts/vim-auto-save'
let g:auto_save = 1
let g:auto_save_in_insert_mode = 0
let g:auto_save_silent = 1

Plug 'easymotion/vim-easymotion'
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1

" Print function signature
Plug 'Shougo/echodoc.vim'
let g:echodoc#enable_at_startup = 1

Plug 'haya14busa/incsearch.vim'
let g:incsearch#auto_nohlsearch = 1

" Autocompletion engine
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#ignore_sources = {}
let g:deoplete#ignore_sources.python = ['around']
let g:deoplete#ignore_sources.c = ['around']

Plug 'zchee/deoplete-jedi'
Plug 'zchee/deoplete-go'
Plug 'zchee/deoplete-zsh'
Plug 'zchee/deoplete-clang'
let g:deoplete#sources#clang#libclang_path = '/usr/lib/llvm-3.8/lib/libclang.so.1'
let g:deoplete#sources#clang#clang_header = '/usr/lib/llvm-3.8/lib/clang/'
let g:deoplete#sources#clang#sort_algo = 'priority'

Plug 'sebastianmarkow/deoplete-rust'
Plug 'Shougo/neco-vim'

" SudoRead, SudoWrite
Plug 'chrisbra/sudoedit.vim'
let g:sudo_no_gui=1

" Various text objects
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-line' " l
Plug 'mattn/vim-textobj-url' " u
" Plug 'kana/vim-textobj-function' " f
" Plug 'michaeljsmith/vim-indent-object' " i I
" Plug 'kana/vim-textobj-entire' " e
" Plug 'kana/vim-textobj-fold' " z
" Plug 'paulhybryant/vim-textobj-path' " p
" Plug 'beloglazov/vim-textobj-quotes' " q
" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nztzv
nnoremap N Nztzv


Plug 'vim-scripts/ReplaceWithRegister' " gr gx
" Plug 'christoomey/vim-titlecase' " gt
Plug 'christoomey/vim-system-copy' " cp
Plug 'christoomey/vim-sort-motion' " gs

" Must have surround functionality
Plug 'tpope/vim-surround'

" Substitute improved (casing, plural)
" Coercions (crs, crc, cru, etc)
Plug 'tpope/vim-abolish'

" I do not know why commenting requires plugin, must have functionality
Plug 'scrooloose/nerdcommenter'
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code
" indentation
let g:NERDDefaultAlign = 'left'
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

Plug 'tpope/vim-commentary'

" git integration (todo: learn how to use this)
Plug 'tpope/vim-fugitive'
" GitHub/BB extension for fugitive.vim
Plug 'tpope/vim-rhubarb'
Plug 'tommcdo/vim-fubitive'

" Symbols on the left showing what has changed
Plug 'airblade/vim-gitgutter'

" Nice left panel with tree structured files
Plug 'scrooloose/nerdtree'
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeHighlightCursorline=1
let g:NERDTreeWinSize=50

" Symbols in nerdtree
Plug 'xuyuanp/nerdtree-git-plugin'

" Intelligently toggling line numbers
Plug 'myusuf3/numbers.vim'

" Handy bracket mappings
Plug 'tpope/vim-unimpaired'

" Help alligning text
Plug 'godlygeek/tabular'

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

" Changes Vim working directory to project root
" Plug 'airblade/vim-rooter'
" let g:rooter_silent_chdir = 1
" let g:rooter_patterns = ['.vim_root']
" let g:rooter_manual_only = 1

" Autoformat
Plug 'sbdchd/neoformat'
let g:neoformat_basic_format_trim = 1
let g:neoformat_basic_format_retab = 1
let g:neoformat_only_msg_on_error = 1
let g:neoformat_run_all_formatters = 1
let g:neoformat_enabled_python = ['yapf', 'isort']
let g:neoformat_enabled_go = ['goimports']
let g:neoformat_enabled_c = ['clangformat']


" Transition between multiline and single-line code
Plug 'AndrewRadev/splitjoin.vim'

" Eclipse like autoopening of quotes/parenthesis
Plug 'raimondi/delimitmate'
let g:delimitMate_expand_cr = 1

" Make the yanked region
Plug 'machakann/vim-highlightedyank'

" Hilight/remove trailing whitespaces
" Plug 'ntpeters/vim-better-whitespace'

" Plug 'Yggdroot/indentLine'

" automatically adjusts 'shiftwidth' and 'expandtab' heuristically
" based on the current file
" Plug 'tpope/vim-sleuth'

" Plug 'kien/rainbow_parentheses.vim'

" This extension is so broken!!! (history/copy/paste)
" Plug 'terryma/vim-multiple-cursors'
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_next_key='<C-s>'
" let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'

" Nice gui undo tree
Plug 'sjl/gundo.vim'

Plug 'neomake/neomake'          " async linter
let g:neomake_verbose=0
let g:neomake_rust_cargo_command = ['test', '--no-run']
let g:neomake_c_enabled_makers = ['clangcheck']

Plug 'kshenoy/vim-signature'    " show marks

" Fix '.' key on some plugins
Plug 'tpope/vim-repeat'

" Snippets
Plug 'SirVer/ultisnips'
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

Plug 'honza/vim-snippets'

" This should improve highlight while find/replace
Plug 'osyo-manga/vim-over'

" Mirroring files on various remote hosts
Plug 'zenbro/mirror.vim'

" Plug 'Shougo/vimproc.vim', {'do' : 'make'}

" Python
Plug 'davidhalter/jedi-vim', {'for': ['python', 'python3']}
let g:jedi#completions_enabled = 0
let g:jedi#show_call_signatures = 0
let g:jedi#goto_command = "<C-]>"

Plug 'tmhedberg/SimpylFold', {'for': ['python', 'python3']}
Plug 'jmcantrell/vim-virtualenv', {'for': ['python', 'python3']}
Plug 'glench/vim-jinja2-syntax'
" http://ipython.readthedocs.io/en/stable/install/kernel_install.html
" Plug 'bfredl/nvim-ipy'          " ipython frontend, todo: fix
Plug 'mfukar/robotframework-vim', { 'for': ['robot'] }
" Plug 'rooprob/vim-behave'

" C support
Plug 'vim-scripts/a.vim', { 'for': ['c', 'cpp']}      " switch to/from heade file
" Plug 'vim-scripts/c.vim', { 'for': ['c', 'cpp']}

" JavaScript
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }

" LaTex
Plug 'lervag/vimtex', { 'for': 'latex' }

" Haskell
Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' }
Plug 'eagletmt/ghcmod-vim', { 'for': 'haskell' }
Plug 'eagletmt/neco-ghc', { 'for': 'haskell' }
Plug 'Twinside/vim-hoogle', { 'for': 'haskell' }
Plug 'mpickering/hlint-refactor-vim', { 'for': 'haskell' }

" Golang
Plug 'fatih/vim-go', { 'for': 'go' }

" Rust
Plug 'rust-lang/rust.vim', { 'for': 'rust' }

" Ruby
" Plug 'vim-ruby/vim-ruby'

" gx to open url in browser
Plug 'tyru/open-browser.vim'

" Panel with tags
Plug 'majutsushi/tagbar'
let g:tagbar_autoclose=1
Plug 'ctrlpvim/ctrlp.vim'
let g:ctrlp_map = '<leader>t'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
let g:fzf_command_prefix = 'Fzf'
Plug 'pbogut/fzf-mru.vim'
Plug 'rking/ag.vim'

Plug 'elzr/vim-json'
Plug 'stephpy/vim-yaml'
Plug 'roalddevries/yaml.vim'    " yaml folding
Plug 'ekalinin/dockerfile.vim'
Plug 'ClockworkNet/vim-junos-syntax'


Plug 'plasticboy/vim-markdown'

Plug 'vim-airline/vim-airline'
let g:airline_powerline_fonts = 1
let g:airline_exclude_preview = 1
let g:airline_detect_spell=0
let g:airline_detect_spelllang=0
" let g:airline_section_x=""
" let g:airline_section_b=""
let g:airline_left_sep=''
let g:airline_right_sep=''

Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'

Plug 'dhruvasagar/vim-table-mode'

" Color themes
Plug 'frankier/neovim-colors-solarized-truecolor-only'
Plug 'crusoexia/vim-monokai'
Plug 'morhetz/gruvbox'
Plug 'joshdick/onedark.vim'
call plug#end()

" }}}

" Key Mappings {{{

let mapleader=","

" more tmux like behavior
nnoremap <C-w>c :tabedit %<cr>

" Open file prompt with current path
nmap <leader>e :e <C-R>=expand("%:p:h") . '/'<cr>

inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>
inoremap <Space> <Space><C-g>u
inoremap <c-r> <c-g>u<c-r>
inoremap <c-z> <c-o>u
inoremap <c-y> <c-o><c-r>


nmap <c-]> <c-]>zt
nmap <c-t> <c-t>zt
nmap <c-i> <c-i>zt
nmap <c-o> <c-o>zt
nmap gd gdzt
nmap * *zt
nmap # #zt

" nmap <C-n> :bnext<cr>
" nmap <C-p> :bprevious<cr>

" better indentation (stay in visual mode)
vmap < <gv
vmap > >gv

" Visual linewise up and down by default (and use gj gk to go quicker)
noremap <Up> gk
noremap <Down> gj
noremap j gj
noremap k gk

" noremap <Leader>q q
" nmap q <Nop>

" https://github.com/mhinz/vim-galore#saner-command-line-history
cmap <c-n> <down>
cmap <c-p> <up>
cmap <c-a> <home>

nmap <silent> <leader><leader> :nohl<cr>

" http://vim.wikia.com/wiki/highlight_all_search_pattern_matches
nmap <silent> y/ :let @/='\<<c-r>=expand("<cword>")<cr>\>'<cr>:set hls<cr>

" just in case I will use nvim terminal
tmap <c-\><c-\> <c-\><c-n><c-w><c-w>

let g:NERDCreateDefaultMappings = 0
nmap <C-_> <Plug>NERDCommenterToggle
nmap <C-g>gc <Plug>NERDCommenterAppend
xmap gcs    <Plug>NERDCommenterSexy
xmap gcu    <Plug>NERDComUncommentLine

nmap <leader>o :Neoformat<cr>

" Highlight all instances of word under cursor, when idle.
" Useful when studying strange source code.
" Type z/ to toggle highlighting on/off.
" http://vim.wikia.com/wiki/VimTip572
nmap z/ :if AutoHighlightToggle()<Bar>set hls<Bar>endif<cr>
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

map <leader>ds :windo diffthis<cr>
map <leader>de :windo diffoff<cr>
map <leader>du :diffupdate<cr>
" map <leader>du :nohl<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>

" ndo map /  <Plug>(incsearch-forward)
" map ?  <Plug>(incsearch-backward)
" map g/ <Plug>(incsearch-stay)
map n  <Plug>(incsearch-nohl-n)ztzv
map N  <Plug>(incsearch-nohl-N)ztzv
map *  <Plug>(incsearch-nohl-*)zt
map #  <Plug>(incsearch-nohl-#)zt
map g* <Plug>(incsearch-nohl-g*)zt
map g# <Plug>(incsearch-nohl-g#)zt

nmap <leader>p :FzfFiles<cr>
nmap <leader>P :FzfCommands<cr>
nmap <A-b> :FzfBuffer<cr>
nmap <leader>b :FzfBuffer<cr>
" nmap <leader>h :FzfHistory<cr>
cmap <C-s> FzfHistory:<cr>
nmap <leader>/ :FzfCommands<cr>
nmap <leader>m :FZFMru<cr>

nmap <A-e> :TagbarToggle<cr>

" Settings for openbrowser plugin
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

nmap t <Plug>(easymotion-s2)
vmap tk <Plug>(easymotion-k)
vmap tj <Plug>(easymotion-j)
vmap th <Plug>(easymotion-linebackward)
vmap tl <Plug>(easymotion-lineforward)

function! IsNERDTreeOpen()
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

function! ToggleFindNerd()
  if IsNERDTreeOpen()
    exec ':NERDTreeToggle'
  else
    exec ':NERDTreeFind'
  endif
endfunction

" nmap <c-k><c-b> <esc>:call ToggleFindNerd()<cr>
nmap <a-1> <esc>:call ToggleFindNerd()<cr>

" navigate location window (simmilar to quickfix)
nmap [l :lprev<cr>zt
nmap ]l :lnext<cr>zt

" push/pull to remote host (mirror plugin)
nmap <leader>rh :MirrorPush<cr>
nmap <leader>rd :MirrorDiff<cr>
nmap <leader>rr :MirrorReload<cr>

" open session
nmap <leader>so :SessionOpen<cr>

inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
    return deoplete#mappings#close_popup() . "\<CR>"
endfunction

" toggle spell checking
map <leader>ss :set spell!<cr>

nmap <leader>l :set list!<cr>

" }}}

" Custom misc functions {{{
function! SynStackFun()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
command SyntaxStack call SynStackFun()

command FgColor :echo synIDattr(synIDtrans(synID(line("."), col("."), 1)), "fg")
command BgColor :echo synIDattr(synIDtrans(synID(line("."), col("."), 1)), "bg")


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

" Auto Commands {{{

" run lint on save
call neomake#configure#automake('rw', 750)

" always insert mode when focusing terminal
autocmd BufWinEnter,WinEnter term://* startinsert

" Remove trailing whitespace on file save
autocmd BufWritePre * :%s/\s\+$//e

" }}}

" Colors {{{

set termguicolors

set background=dark
" silent! colorscheme onedark
silent! colorscheme monokai
" silent! colorscheme gruvbox

" silent! colorscheme solarized
" set background=light


" hilight matching parenthesis style
hi MatchParen      guifg=none guibg=none gui=underline

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
" }}}

