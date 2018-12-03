let mapleader=","

if empty(glob('~/.vim/autoload/plug.vim'))
  set nocompatible
  function! PrepareVim()
    silent !curl -sfLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    silent !mkdir -p ~/.vim/undo
    source $MYVIMRC
    PlugInstall --sync
    source $MYVIMRC
 endfunc
  command! Prep :call PrepareVim()
else
  call plug#begin('~/.vim/plugged')
  Plug 'tpope/vim-sensible'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-fugitive'
  Plug '907th/vim-auto-save'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'pbogut/fzf-mru.vim'
  Plug 'mileszs/ack.vim'
  Plug 'easymotion/vim-easymotion'
  Plug 'machakann/vim-highlightedyank'
  Plug 'zenbro/mirror.vim'
  Plug 'troydm/zoomwintab.vim'
  Plug 'kana/vim-textobj-user'
  Plug 'kana/vim-textobj-line'
  Plug 'mattn/vim-textobj-url'
  Plug 'bps/vim-textobj-python', {'for': ['python', 'python3']}
  Plug 'airblade/vim-gitgutter'
  Plug 'kshenoy/vim-signature'
  Plug 'raimondi/delimitmate'
  Plug 'RRethy/vim-illuminate'
  Plug 'sbdchd/neoformat'
  if has('python')
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'
  endif
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'crusoexia/vim-monokai'
  call plug#end()

  nnoremap <leader>gs :Gstatus<cr>
  nnoremap <leader>gd :Gdiff<cr>
  nnoremap <leader>gb :Gblame<cr>
  nnoremap <leader>gw :Gwrite
  let g:auto_save = 1
  let g:auto_save_in_insert_mode = 0
  let g:auto_save_silent = 1
  let g:fzf_command_prefix = 'Fzf'
  nnoremap <leader>p :FzfFiles<cr>
  nnoremap <leader>P :FzfCommands<cr>
  nnoremap <leader>b :FzfBuffer<cr>
  nnoremap <leader>m :FZFMru<cr>
  let g:EasyMotion_do_mapping = 0
  let g:EasyMotion_smartcase = 1
  nmap t  <Plug>(easymotion-s2)
  vmap tk <Plug>(easymotion-k)
  vmap tj <Plug>(easymotion-j)
  vmap th <Plug>(easymotion-linebackward)
  vmap tl <Plug>(easymotion-lineforward)
  nnoremap <leader>rr :MirrorPush<cr>
  nnoremap <leader>rd :MirrorDiff<cr>
  nnoremap <leader>rl :MirrorReload<cr>
  let g:zoomwintab_remap = 0
  nnoremap <silent> <c-w>z :ZoomWinTabToggle<cr>
  vnoremap <silent> <c-w>z <c-\><c-n>:ZoomWinTabToggle<cr>gv
  let g:delimitMate_expand_cr = 1
  let g:neoformat_basic_format_trim = 1
  let g:neoformat_basic_format_retab = 1
  let g:neoformat_only_msg_on_error = 1
  let g:neoformat_run_all_formatters = 1
  let g:neoformat_enabled_python = ['yapf', 'isort']
  let g:neoformat_enabled_c = ['clangformat']
  nnoremap <leader>o :Neoformat<cr>
  let g:UltiSnipsEditSplit="vertical"
  let g:UltiSnipsExpandTrigger="<tab>"
  let g:UltiSnipsJumpForwardTrigger="<tab>"
  let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
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
endif

set nopaste
set clipboard=unnamedplus
set mouse=a
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
set diffopt+=vertical
silent! set diffopt+=indent-heuristic,algorithm:patience
set colorcolumn=
set virtualedit=block
set showtabline=0
set ruler
set autoread
set startofline
set scrolloff=15
set nohlsearch
set incsearch
set ignorecase
set smartcase
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab
set smartindent
set nosplitbelow
set splitright
set previewheight=20
set hidden
set undofile
set undodir=~/.vim/undo//
set nobackup
set noswapfile
set spelllang=en_us
set wildmode=longest:full,full
set wildmenu
set wildignore+=*/.git/*,*.pyc,*.swp,*.o
set wildignorecase
set path+=**
set completeopt=menuone,longest
set noshowmode
set showcmd
set signcolumn=yes
set shortmess+=cW
set background=dark
nnoremap <c-w>c :tabedit %<cr>
inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>
inoremap <c-r> <c-g>u<c-r>

vnoremap < <gv
vnoremap > >gv

noremap j gj
noremap k gk

cnoremap <c-n> <down>
cnoremap <c-p> <up>
cnoremap <c-a> <home>

nmap n nzt
nmap N Nzt
nmap * *zt
nmap # #zt
nmap g* g*zt
nmap g# g#zt
nmap <c-]> <c-]>zt
nmap <c-t> <c-t>zt
nmap <c-i> <c-i>zt
nmap <c-o> <c-o>zt
nmap gd gdzt

noremap <leader>ds :windo diffthis<cr>
noremap <leader>de :windo diffoff<cr>
nnoremap <leader>z :let @z=expand("<cword>")<cr>q:i%s/\C\v<<esc>"zpa>//g<esc>hi
nnoremap <leader>e :e $MYVIMRC<cr>

nnoremap <silent> <leader>q :botright copen 10<cr>
nnoremap <silent> <leader>l :botright lopen 10<cr>

augroup smartnumbers
  au!
  au InsertEnter * if empty(&buftype) | setl nornu | endif
  au InsertLeave * if empty(&buftype) | setl rnu | endif
  au WinEnter,BufNewFile,BufReadPost * if empty(&buftype) | setl rnu | endif
  au WinLeave   * if empty(&buftype) | set rnu< | endif
augroup end

augroup filetype_settings
  au!
  au FileType html setl ts=2 sts=2 sw=2
  au FileType yaml setl fdm=indent ts=2 sts=2 sw=2
  au FileType gitcommit setl spell comments=b:#
  au FileType vim setl fdm=marker ts=2 sts=2 sw=2
  au FileType c,cpp setl fdm=syntax cms=//%s
  au FileType sql setl cms=--%s ts=2 sts=2 sw=2
  au FileType python
    \  let b:delimitMate_nesting_quotes = ['"']
    \| let b:delimitMate_smart_quotes = '\%([a-eg-qs-zA-Z_]\|[^[:punct:][:space:]fr]\|\%(\\\\\)*\\\)\%#\|\%#\%(\w\|[^[:space:][:punct:]]\)'
  au FileType markdown setl spell | let b:delimitMate_nesting_quotes = ['`']
  au FileType qf nnoremap <silent> <buffer> q :cclose<cr>:lclose<cr>
  au FileType help nnoremap <silent> <buffer> q :q<cr>
  au FileType cmake setl cms=#%s
augroup end

augroup particular_file_settings
  au!
  autocmd BufRead */.zshrc set fdm=marker
augroup end

if (v:version >= 800)
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
  let &t_SI = "\<Esc>[6 q"
  let &t_SR = "\<Esc>[4 q"
  let &t_EI = "\<Esc>[2 q"
  set ttimeoutlen=50
  autocmd VimEnter * silent !echo -ne "\e[2 q"
endif

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
endfunction
au ColorScheme * call ColorCustomizations()

silent! colorscheme monokai
syntax enable
