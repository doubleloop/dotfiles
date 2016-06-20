let mapleader=","
map ; :

" Autoreloade .vimrc
autocmd! bufwritepost $MYVIMRC source $MYVIMRC

" https://github.com/neovim/neovim/wiki/FAQ#how-can-i-use-true-colors-in-the-terminal
syntax enable
set termguicolors
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
set background=dark
" set background=light

" Clipboard sanity
set pastetoggle="<F2>"
set clipboard=unnamedplus

" Line numbers
set number
set relativenumber 
set textwidth=79
set nowrap
set nofoldenable
" set foldlevel=1

set colorcolumn=80
" highlight ColorColumn ctermbg=233 

set noshowmode      " Don't show current mode (vim airline).
set showtabline=0   " do not disply tab on the top os the screen
set ruler           " disply line/col in status bar
set autoread

" Enable persistent undo so that undo history persists across vim sessions
set undofile
set undodir=~/.vim/undo

" disable - as word separator
set iskeyword+=-

" search settings
set hlsearch
set ignorecase
set smartcase
nnoremap <silent> <leader><leader> :nohl<cr>
" http://vim.wikia.com/wiki/highlight_all_search_pattern_matches
nnoremap <silent> <leader>/ :let @/='\<<c-r>=expand("<cword>")<cr>\>'<cr>:set hls<CR>
vnoremap <silent> <leader>/ y/<c-r>"<cr>

" Highlight all instances of word under cursor, when idle.
" Useful when studying strange source code.
" Type z/ to toggle highlighting on/off.
" http://vim.wikia.com/wiki/VimTip572
nnoremap z/ :if AutoHighlightToggle()<Bar>set hls<Bar>endif<CR>
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

" better indentation
vnoremap < <gv
vnoremap > >gv
vnoremap <tab> >gv
vnoremap <s-tab> <gv

set nobackup
set nowritebackup
set noswapfile

" Spelling
set dictionary+=/usr/share/dict/words
set thesaurus+=/usr/share/dict/mthesaur.txt


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
Plug 'vim-auto-save'

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

Plug 'scrooloose/nerdtree'
" Plug 'jistr/vim-nerdtree-tabs'
" Plug 'xuyuanp/nerdtree-git-plugin'
" Plug 'ryanoasis/vim-devicons'

Plug 'tpope/vim-obsession'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'rking/ag.vim'
" Plug 'Numkil/ag.nvim'
Plug 'townk/vim-autoclose'
Plug 'terryma/vim-multiple-cursors'
Plug 'simnalamburt/vim-mundo'   " gundo with nvim support
Plug 'Shougo/deoplete.nvim'     " copletions
Plug 'neomake/neomake'          " async linter
Plug 'kshenoy/vim-signature'    " show marks
" Plug 'bfredl/nvim-ipy'          " ipython frontend, todo: fix
Plug 'fatih/vim-go'
Plug 'bruno-/vim-man'
Plug 'zenbro/mirror.vim'
Plug 'davidhalter/jedi-vim'
Plug 'tyru/open-browser.vim'
Plug 'honza/vim-snippets'
" Plug 'mhinz/vim-grepper'
Plug 'majutsushi/tagbar'
Plug 'ervandew/supertab'
Plug 'shougo/unite.vim'
Plug 'elzr/vim-json'
Plug 'stephpy/vim-yaml'
Plug 'tmhedberg/SimpylFold'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'altercation/vim-colors-solarized'
Plug '29decibel/codeschool-vim-theme'
Plug 'ciaranm/inkpot'
Plug 'jonathanfilip/vim-lucius'
Plug 'pyte'
Plug 'tomasr/molokai'
Plug 'peaksea'
Plug 'godlygeek/csapprox'       " Make gvim-only colorschemes work 
                                " transparently in terminal vim

Plug 'vim-scripts/a.vim'      " switch to/from heade file
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

" Nerdtree
let NERDTreeHighlightCursorline=1

" Use deoplete.
let g:deoplete#enable_at_startup = 1

" Airline
let g:airline_powerline_fonts = 1

" sudoedit conf
let g:sudo_no_gui=1

let g:neomake_verbose=0

" run automake 
autocmd! BufWritePost,BufEnter * Neomake

let g:SuperTabDefaultCompletionType = "<c-n>"

" Autosave
let g:auto_save = 1 
let g:auto_save_in_insert_mode = 0
let g:auto_save_silent = 1

" remap multicursor to use ctrl+s
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_next_key='<C-s>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'

let g:pymode_lint_cwindow = 0
let g:pymode_rope_goto_definition_bind = "<C-]>"
let g:jedi#goto_command = "<C-]>"

if has("nvim")
    " Mapping selecting mappings
    nmap <leader><tab> <plug>(fzf-maps-n)
    xmap <leader><tab> <plug>(fzf-maps-x)
    omap <leader><tab> <plug>(fzf-maps-o)

    " Insert mode completion
    imap <c-x><c-k> <plug>(fzf-complete-word)
    imap <c-x><c-f> <plug>(fzf-complete-path)
    imap <c-x><c-j> <plug>(fzf-complete-file-ag)
    imap <c-x><c-l> <plug>(fzf-complete-line)

    nmap <c-p> :FzfFiles<cr>
    cmap <c-p> FzfCommands<cr>
    cmap <c-h> FzfCommands<cr>

    nmap <c-b> :FzfBuffer<cr>
    let g:fzf_command_prefix = 'Fzf'
endif

let g:ag_highlight=1
nmap <leader>a :Ag 
xmap <leader>a "ay:Ag '<C-R>a'

" let g:solarized_termcolors=256
" let g:solarized_termcolors=16
" colorscheme solarized
" colorscheme peaksea
colorscheme molokai

" Git grepper
" nmap <leader>g :Grepper<cr>
" nmap gs <plug>(GrepperOperator)
" xmap gs <plug>(GrepperOperator)
" " Mimic :grep and make ag the default tool.
" let g:grepper = {
"     \ 'tools': ['ag', 'git', 'grep'],
"     \ 'open':  1,
"     \ 'jump':  0,
"     \ 'highlight': 1, }

" colorscheme codeschool
" colorscheme inkpot
" colorscheme lucius      " nice light theme
" colorscheme pyte

