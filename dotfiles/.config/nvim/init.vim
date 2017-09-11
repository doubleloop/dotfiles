" neovim-npython installations
let g:python_host_prog = $PYTHON2_NVIM_VIRTUALENV
let g:python3_host_prog = $PYTHON3_NVIM_VIRTUALENV

" Basic Settings {{{

syntax enable

" https://github.com/neovim/neovim/wiki/FAQ#how-can-i-use-true-colors-in-the-terminal
set termguicolors
set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
set background=dark
" set background=light

" Clipboard sanity
set pastetoggle="<F2>"
set clipboard=unnamedplus

" Line numbers
set number
" set relativenumber
set textwidth=0
set nowrap
set nofoldenable
set foldmethod=syntax
" donot fold diff
set diffopt=filler,context:1000000

set colorcolumn=80

set showcmd
set showtabline=0   " do not disply tab on the top os the screen
set ruler           " disply line/col in status bar
set autoread

" Enable persistent undo so that undo history persists across vim sessions
set undofile

" disable - as word separator
set iskeyword+=-

" commands that can go to next line (added bs and space)
set whichwrap=<,>,[,],b,s

set startofline     " scrolling puts cursor on first non blank character
set so=5            " cursor margins

" search settings
set hlsearch
set ignorecase
set inccommand=nosplit

set tabstop=4
set softtabstop=4
set shiftwidth=4    " Indentation amount for < and > commands.
set shiftround
set expandtab       " Insert spaces when TAB is pressed.

set nosplitbelow
set splitright      " Vertical split to right of current.
set previewheight=40

" http://stackoverflow.com/questions/102384/using-vims-tabs-like-buffers
set hidden

set nobackup
set nowritebackup
set noswapfile

" Spelling
set dictionary+=/usr/share/dict/words
set thesaurus+=/usr/share/dict/mthesaur.txt
set spelllang=en_us

" tab completion
set wildmode=longest,full
set wildmenu

set completeopt=menuone,longest,noselect
set noshowmode
set path+=**

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

" Autocompletion engine
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#ignore_sources = {}
" let g:deoplete#ignore_sources._ = ['buffer', 'around']

Plug 'zchee/deoplete-jedi'
Plug 'zchee/deoplete-go'
" Plug 'sebastianmarkow/deoplete-rust'

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

Plug 'vim-scripts/ReplaceWithRegister' " gr gx
" Plug 'christoomey/vim-titlecase' " gt
Plug 'christoomey/vim-system-copy' " cp
Plug 'christoomey/vim-sort-motion' " gs

" Must have surround functionality
Plug 'tpope/vim-surround'

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

" Close buffer but do not close window
Plug 'moll/vim-bbye'
"
" git integration (todo: learn how to use this)
Plug 'tpope/vim-fugitive'
" GitHub/BB extension for fugitive.vim
Plug 'tpope/vim-rhubarb'
Plug 'tommcdo/vim-fubitive'

" Symbols on the left showing what has changed
Plug 'airblade/vim-gitgutter'

" Nice left panel with tree structured files
Plug 'scrooloose/nerdtree'
let g:NERDTreeHighlightCursorline=1
let g:NERDTreeWinSize=50


" Symbols in nerdtree
Plug 'xuyuanp/nerdtree-git-plugin'

" Intelligently toggling line numbers
Plug 'myusuf3/numbers.vim'

" Handy bracket mappings
Plug 'tpope/vim-unimpaired'

" Help alligning text
" Plug 'godlygeek/tabular'

" Improved sessions
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'
let g:session_autosave='yes'
let g:session_autoload='yes'
let g:session_default_overwrite=1
let g:session_autosave_periodic='1'
let g:session_autosave_silent=1
let g:session_default_to_last=1
let g:session_command_aliases=1
let g:session_persist_colors=0
let g:session_persist_font=0

" Handle sessions, maintain default session, use qa to exit vim
Plug 'kopischke/vim-stay'

" Changes Vim working directory to project root
Plug 'airblade/vim-rooter'
let g:rooter_silent_chdir = 1
let g:rooter_patterns = ['.vim_root']
let g:rooter_manual_only = 0

" Autoformat
Plug 'sbdchd/neoformat'
let g:neoformat_basic_format_trim = 1
let g:neoformat_run_all_formatters = 1
let g:neoformat_enabled_python = ['yapf', 'isort']
let g:neoformat_enabled_go = ['goimports']


" Transition between multiline and single-line code
Plug 'AndrewRadev/splitjoin.vim'

" Eclipse like autoopening of quotes/parenthesis
Plug 'jiangmiao/auto-pairs'

" Hilight/remove trailing whitespaces
" Plug 'ntpeters/vim-better-whitespace'

" Plug 'Yggdroot/indentLine'

" automatically adjusts 'shiftwidth' and 'expandtab' heuristically
" based on the current file
Plug 'tpope/vim-sleuth'

" Plug 'kien/rainbow_parentheses.vim'

" This extension is so broken!!! (history/copy/paste)
Plug 'terryma/vim-multiple-cursors'
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

" Python
Plug 'davidhalter/jedi-vim'
let g:jedi#completions_enabled = 0
let g:jedi#show_call_signatures = 0
let g:jedi#goto_command = "<C-]>"

Plug 'fisadev/vim-isort'
let g:vim_isort_python_version = 'python3'
let g:vim_isort_map = ''
Plug 'tmhedberg/SimpylFold'
Plug 'jmcantrell/vim-virtualenv'
Plug 'glench/vim-jinja2-syntax'
" Plug 'bps/vim-textobj-python'
" http://ipython.readthedocs.io/en/stable/install/kernel_install.html
" Plug 'bfredl/nvim-ipy'          " ipython frontend, todo: fix
Plug 'mfukar/robotframework-vim'

" C support
Plug 'vim-scripts/a.vim'      " switch to/from heade file
" Todo
Plug 'rip-rip/clang_complete'
let g:clang_library_path='/usr/lib/llvm-3.8/lib'

" JavaScript
Plug 'pangloss/vim-javascript'

" LaTex
Plug 'lervag/vimtex'

" Haskell
Plug 'eagletmt/ghcmod-vim'

" Golang
Plug 'fatih/vim-go'
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

" Rust
Plug 'rust-lang/rust.vim'

" Ruby
" Plug 'vim-ruby/vim-ruby'

" gx to open url in browser
Plug 'tyru/open-browser.vim'

" Panel with tags
Plug 'majutsushi/tagbar'

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

" Plug 'Konfekt/FastFold'

" Syntax handling of markdown
Plug 'plasticboy/vim-markdown'

Plug 'vim-airline/vim-airline'
let g:airline_powerline_fonts = 1
let g:airline_exclude_preview = 1
let g:airline_detect_spell=0
let g:airline_detect_spelllang=0
" let g:airline#extensions#vimagit#enabled = 0

" let g:airline#extensions#tabline#enabled = 1
Plug 'vim-airline/vim-airline-themes'

Plug 'ryanoasis/vim-devicons'

" Color themes
Plug 'godlygeek/csapprox'       " Make gvim-only colorschemes work
" transparently in terminal vim
" Plug 'altercation/vim-colors-solarized'
" let g:solarized_termcolors=256
" let g:solarized_termcolors=16
" Plug '29decibel/codeschool-vim-theme'
" Plug 'ciaranm/inkpot'
" Plug 'jonathanfilip/vim-lucius'
" Plug 'pyte'
" Plug 'peaksea'
Plug 'tomasr/molokai'
" let g:molokai_original = 1
let g:rehash256 = 1
call plug#end()

" }}}

" Key Mappings {{{

let mapleader=","

" more tmux like behavior
noremap <C-w>; <C-w>p
noremap <C-w>n :bnext<cr>
noremap <C-w>p :bprevious<cr>
noremap <C-w>N :bnext<cr>
noremap <C-w>P :bprevious<cr>
noremap <C-w>c :tabnew<cr>
noremap <C-w>z :tabedit %<cr>

" nmap <C-n> :bnext<cr>
" nmap <C-p> :bprevious<cr>

" better indentation (stay in visual mode)
vmap < <gv
vmap > >gv
vmap <tab> >gv
vmap <s-tab> <gv

" Visual linewise up and down by default (and use gj gk to go quicker)
noremap <Up> gk
noremap <Down> gj
noremap j gj
noremap k gk

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv


imap <c-v> <c-r>"
nmap <cr> o<esc>

noremap <Leader>q q
nmap q <Nop>

" https://github.com/mhinz/vim-galore#saner-command-line-history
cmap <c-n>  <down>
cmap <c-p>  <up>

nmap <silent> <leader><leader> :nohl<cr>
" fix syntax hl when doing diff
nmap <leader>r :nohl<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>
" http://vim.wikia.com/wiki/highlight_all_search_pattern_matches
" nmap <silent> <leader>/ :let @/='\<<c-r>=expand("<cword>")<cr>\>'<cr>:set hls<CR>
vmap <silent> <leader>/ y/<c-r>"<cr>

" todo: think of sane terminal navigation
tmap <C-w> <C-\><C-n><C-w>
" tmap <silent> <C-h> <C-\><C-n><C-w>h
" tmap <silent> <C-j> <C-\><C-n><C-w>j
" tmap <silent> <C-k> <C-\><C-n><C-w>k
" tmap <silent> <C-l> <C-\><C-n><C-w>l
" nmap <silent> <S-j> gT
" nmap <silent> <S-k> gt
" tmap <silent> <S-h> <C-\><C-n>gT
" tmap <silent> <S-l> <C-\><C-n>gt
" tmap <Esc> <C-\><C-n>
" autocmd BufWinEnter,WinEnter term://* startinsert

nmap <C-_> <Plug>NERDCommenterToggle
xmap <C-_> <Plug>NERDCommenterToggle
" nmap ,<C-_> <Plug>NERDCommenterSexy
" xmap ,<C-_> <Plug>NERDCommenterSexy
nmap <C-g><C-_> <Plug>NERDCommenterAppend
" TODO: insert mode comments


nmap <silent> <leader>o :Neoformat<CR>

" Highlight all instances of word under cursor, when idle.
" Useful when studying strange source code.
" Type z/ to toggle highlighting on/off.
" http://vim.wikia.com/wiki/VimTip572
nmap z/ :if AutoHighlightToggle()<Bar>set hls<Bar>endif<CR>
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




nmap <leader>p :FzfFiles<cr>
nmap <leader>P :FzfCommands<cr>
nmap <A-b> :FzfBuffer<cr>
nmap <leader>b :FzfBuffer<cr>
nmap <leader>h :FzfHistory<cr>
cmap <C-s> FzfHistory:<cr>
nmap <leader>/ :FzfCommands<cr>
nmap <leader>m :FZFMru<cr>

nmap <A-e> :TagbarOpenAutoClose<CR>

" close current buffer but do not close window
nmap <Leader>z :Bdelete<CR>
" cabbrev q Bdelete

" Settings for openbrowser plugin
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

" nmap <Leader>l <Plug>(easymotion-overwin-line)
nmap <Leader>l <Plug>(easymotion-bd-jk)
nmap <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>f <Plug>(easymotion-bd-f)
nmap <leader>t <Plug>(easymotion-bd-t)
vmap <Leader>l <Plug>(easymotion-bd-jk)
vmap <Leader>w <Plug>(easymotion-bd-w)
vmap <Leader>f <Plug>(easymotion-bd-f)
vmap <leader>t <Plug>(easymotion-bd-t)
nmap <Space> <Plug>(easymotion-jumptoanywhere)
vmap <Space> <Plug>(easymotion-jumptoanywhere)

nmap <c-k><c-b> :NERDTreeFind<cr>
nmap <a-1> :NERDTreeToggle<cr>

" navigate location window (simmilar to quickfix)
nmap [l :lprev<CR>
nmap ]l :lnext<CR>

" push/pull to remote host
nmap <leader>hh :MirrorPush
nmap <leader>hd :MirrorDiff
nmap <leader>hr: MirrorReload

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
" }}}

" Auto Commands {{{

" http://vim.wikia.com/wiki/Highlight_current_line
augroup CursorLine
    au!
    autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    autocmd WinLeave * setlocal nocursorline
augroup END

" run lint on save
autocmd! BufWritePost,BufEnter * Neomake

" always insert mode when focusing terminal
" autocmd BufWinEnter,WinEnter term://*/zsh startinsert

" }}}

" Colors {{{

" silent! colorscheme codeschool
" silent! colorscheme inkpot
" silent! colorscheme lucius      " nice light theme
" silent! colorscheme pyte
" silent! colorscheme solarized
" silent! colorscheme peaksea
silent! colorscheme molokai

" hilight matching parenthesis style
hi MatchParen      guifg=none guibg=none gui=underline

" }}}
