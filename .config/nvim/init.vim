" Autoreloade .vimrc
autocmd! bufwritepost $MYVIMRC source $MYVIMRC

" Clipboard sanity
set pastetoggle="<F2>"
set clipboard=unnamedplus

" Line numbers
set number
set relativenumber 
set textwidth=79
set nowrap
" set colorcolumn=80
" highlight ColorColumn ctermbg=233 
"
set showmode        " Show current mode.
set showtabline=0   " do not disply tab on the top os the screen
set ruler           " disply line/col in status bar

" search settings
set hlsearch
set ignorecase
set smartcase

set tabstop=4
set softtabstop=4
set shiftwidth=4    " Indentation amount for < and > commands.
set shiftround
set expandtab       " Insert spaces when TAB is pressed.

" todo: how to prevent terminal escape if edge winow/single tab
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l
nnoremap <S-h> gT
nnoremap <S-l> gt
tnoremap <S-h> <C-\><C-n>gT
tnoremap <S-l> <C-\><C-n>gt
" tnoremap <Esc> <C-\><C-n>
autocmd BufWinEnter,WinEnter term://* startinsert
set splitbelow      " Horizontal split below current.
set splitright      " Vertical split to right of current.

" http://stackoverflow.com/questions/102384/using-vims-tabs-like-buffers
set hidden

" http://vim.wikia.com/wiki/Su-write
command! W w !sudo tee % > /dev/null

" better indentation
vnoremap < <gv
vnoremap > >gv

set nobackup
set nowritebackup
set noswapfile




" automatic vim-plug instalation
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

" Plugins
call plug#begin('~/.nvim/plugged')

" Sane pane navigation shortcuts
" Plug 'christoomey/vim-tmux-navigator'

" Various text objects
Plug 'kana/vim-textobj-user'

" SudoRead, SudoWrite
Plug 'chrisbra/sudoedit.vim'

Plug 'kana/vim-textobj-line'
Plug 'mattn/vim-textobj-url'
" Plug 'kana/vim-textobj-function'
" Plug 'glts/vim-textobj-comment'
" Plug 'michaeljsmith/vim-indent-object'
" Plug 'kana/vim-textobj-fold'
" Plug 'bps/vim-textobj-python'
" Plug 'kana/vim-textobj-fold'

Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdcommenter'

" git integration
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

call plug#end()


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Nerd Commenter
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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

nmap <C-_> <Plug>NERDCommenterToggle
xmap <C-_> <Plug>NERDCommenterToggle
" nmap ,<C-_> <Plug>NERDCommenterSexy
" xmap ,<C-_> <Plug>NERDCommenterSexy
nmap <C-g><C-_> <Plug>NERDCommenterAppend
" TODO: insert mode comments


" sudoedit conf
let g:sudo_no_gui=1








