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
  Plug 'tpope/vim-unimpaired'
  Plug '907th/vim-auto-save'
  Plug 'junegunn/fzf', { 'dir': '~/src/fzf', 'do': './install --bin' }
  Plug 'junegunn/fzf.vim'
  Plug 'mileszs/ack.vim'
  Plug 'machakann/vim-highlightedyank'
  Plug 'zenbro/mirror.vim'
  Plug 'troydm/zoomwintab.vim'
  Plug 'kana/vim-textobj-user'
  Plug 'kana/vim-textobj-line'
  Plug 'mattn/vim-textobj-url'
  Plug 'bps/vim-textobj-python', {'for': ['python', 'python3']}
  Plug 'vim-scripts/ReplaceWithRegister'
  Plug 'moll/vim-bbye'
  Plug 'machakann/vim-swap'
  Plug 'airblade/vim-gitgutter'
  Plug 'kshenoy/vim-signature'
  Plug 'raimondi/delimitmate'
  Plug 'RRethy/vim-illuminate'
  Plug 'itchyny/lightline.vim'
  Plug 'crusoexia/vim-monokai'
  call plug#end()

  let g:gitgutter_map_keys = 0
  nmap [c <Plug>GitGutterPrevHunkzt
  nmap ]c <Plug>GitGutterNextHunkzt
  let g:auto_save = 1
  let g:auto_save_in_insert_mode = 0
  let g:auto_save_silent = 1
  let g:auto_save_events = ["CursorHold", "FocusLost", "BufHidden", "ExitPre"]
  let g:fzf_command_prefix = 'Fzf'
  nnoremap <leader>p :FzfFiles<cr>
  nnoremap <leader>: :FzfCommands<cr>
  nnoremap <leader>b :FzfBuffer<cr>
  nnoremap <leader>m :FzfHistory<cr>
  nnoremap <leader><c-r> :FzfHistory:<cr>
  if executable('rg')
    nnoremap <leader>/ :FzfRg<cr>
  elseif executable('ag')
    nnoremap <leader>/ :FzfAg<cr>
  endif
  nnoremap <leader>l :FzfBLines<cr>
  nnoremap <a-e> :FzfBTags<cr>
  nnoremap <leader>rr :MirrorPush<cr>
  nnoremap <leader>rd :MirrorDiff<cr>
  nnoremap <leader>rl :MirrorReload<cr>
  let g:zoomwintab_remap = 0
  nnoremap <silent> <c-w>z :ZoomWinTabToggle<cr>
  vnoremap <silent> <c-w>z <c-\><c-n>:ZoomWinTabToggle<cr>gv
  let g:delimitMate_expand_cr = 1
  let g:swap_no_default_key_mappings = 1
  nmap g< <Plug>(swap-prev)
  nmap g> <Plug>(swap-next)
  nmap g? <Plug>(swap-interactive)
  xmap g? <Plug>(swap-interactive)
  let g:Illuminate_delay = 500
  let g:lightline = { 'colorscheme': 'wombat' }
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
set conceallevel=0
set background=dark
set guioptions-=T
set guioptions-=m
set guioptions-=r
set belloff=all
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
nnoremap gd gdzt
nnoremap G Gzz

noremap <leader>ds :windo diffthis<cr>
noremap <leader>de :windo diffoff<cr>
noremap <leader>dd :Gdiffsplit<cr>
nnoremap <leader>z :let @z=expand("<cword>")<cr>q:i%s/\C\v<<esc>"zpa>//g<esc>hi
nnoremap <leader>e :e $MYVIMRC<cr>

nnoremap <silent> <leader>q :botright copen 10<cr>
" nnoremap <silent> <leader>l :botright lopen 10<cr>
nmap <leader>W :%s/\s\+$//e<cr>

augroup smartnumbers
  au!
  au InsertEnter * if empty(&buftype) | setl nornu | endif
  au InsertLeave * if empty(&buftype) | setl rnu | endif
  au WinEnter,BufNewFile,BufReadPost * if empty(&buftype) | setl rnu | endif
  au WinLeave   * if empty(&buftype) | set rnu< | endif
augroup end

augroup filetype_settings
  au!
  au FileType html,xhtml,css setl ts=2 sts=2 sw=2
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
  au FileType help setl signcolumn=no | nnoremap <silent> <buffer> q :q<cr>
  au FileType cmake setl cms=#%s
augroup end

augroup particular_file_settings
  au!
  autocmd BufRead */.zshrc set fdm=marker
  au BufRead */.aliases set filetype=sh
augroup end

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"
set ttimeoutlen=50

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
endfunction
au ColorScheme * call ColorCustomizations()

silent! colorscheme monokai
syntax enable
