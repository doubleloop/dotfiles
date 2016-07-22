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

" Movement
map k gk
map j gj
map <up> gk
map <down> gj
set whichwrap=<,>,[,],b,s

inoremap <BS> <c-g>u<BS>
inoremap <CR> <c-g>u<CR>
inoremap <del> <c-g>u<del>
inoremap <c-w> <c-g>u<c-w>
inoremap <C-R> <C-G>u<C-R>

" https://github.com/mhinz/vim-galore#saner-command-line-history
cnoremap <c-n>  <down>
cnoremap <c-p>  <up>

nnoremap <leader>l :nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>

autocmd InsertLeave,WinEnter * set cursorline
autocmd InsertEnter,WinLeave * set nocursorline

" search settings
set hlsearch
set ignorecase
set smartcase
nnoremap <silent> <leader><leader> :nohl<cr>
" http://vim.wikia.com/wiki/highlight_all_search_pattern_matches
nnoremap <silent> <leader>/ :let @/='\<<c-r>=expand("<cword>")<cr>\>'<cr>:set hls<CR>
vnoremap <silent> <leader>/ y/<c-r>"<cr>

set foldmethod=syntax

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

" todo: think of sane terminal navigation
" tnoremap <silent> <C-h> <C-\><C-n><C-w>h
" tnoremap <silent> <C-j> <C-\><C-n><C-w>j
" tnoremap <silent> <C-k> <C-\><C-n><C-w>k
" tnoremap <silent> <C-l> <C-\><C-n><C-w>l
nnoremap <silent> <S-j> gT
nnoremap <silent> <S-k> gt
" tnoremap <silent> <S-h> <C-\><C-n>gT
" tnoremap <silent> <S-l> <C-\><C-n>gt
" tnoremap <Esc> <C-\><C-n>
" autocmd BufWinEnter,WinEnter term://* startinsert
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


function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

" Plugins
call plug#begin('~/.nvim/plugged')

" Sane pane navigation shortcuts
Plug 'christoomey/vim-tmux-navigator'
Plug 'vim-auto-save'

Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
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
Plug 'moll/vim-bbye'
" git integration
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

Plug 'scrooloose/nerdtree'
" Plug 'jistr/vim-nerdtree-tabs'
" Plug 'xuyuanp/nerdtree-git-plugin'
" Plug 'ryanoasis/vim-devicons'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'


" Plug 'tpope/vim-obsession'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'rking/ag.vim'
" Plug 'Numkil/ag.nvim'
" Plug 'townk/vim-autoclose'
Plug 'jiangmiao/auto-pairs'
Plug 'kien/rainbow_parentheses.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'simnalamburt/vim-mundo'   " gundo with nvim support
Plug 'Konfekt/FastFold'
Plug 'kopischke/vim-stay'
Plug 'neomake/neomake'          " async linter
Plug 'kshenoy/vim-signature'    " show marks
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" http://ipython.readthedocs.io/en/stable/install/kernel_install.html
Plug 'bfredl/nvim-ipy'          " ipython frontend, todo: fix
Plug 'fatih/vim-go'
Plug 'bruno-/vim-man'
Plug 'zenbro/mirror.vim'
Plug 'davidhalter/jedi-vim'
Plug 'jmcantrell/vim-virtualenv'
Plug 'tyru/open-browser.vim'
" Plug 'mhinz/vim-grepper'
Plug 'majutsushi/tagbar'
Plug 'ervandew/supertab'
Plug 'shougo/unite.vim'

Plug 'elzr/vim-json'
Plug 'stephpy/vim-yaml'
Plug 'roalddevries/yaml.vim'    " yaml folding
Plug 'tmhedberg/SimpylFold'
Plug 'ntpeters/vim-better-whitespace'

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
" let g:deoplete#disable_auto_complete = 1
let g:deoplete#enable_smart_case = 1

let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"


" Airline
let g:airline_powerline_fonts = 1
" let g:airline#extensions#tabline#enabled = 1
let g:bufferline_echo = 0
let g:airline_exclude_preview = 1

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

" let g:pymode_lint_cwindow = 0
" let g:pymode_rope_goto_definition_bind = "<C-]>"
" let g:jedi#goto_command = "<C-]>"

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
    cmap <c-h> FzfCommands<cr>

    nmap <c-b> :FzfBuffer<cr>
    let g:fzf_command_prefix = 'Fzf'
endif

let g:ag_highlight=1
nmap <leader>g :Ag
xmap <leader>g "ay:Ag '<C-R>a'

" atuo strip whitespace on save
autocmd BufWritePre * StripWhitespace

" vim session settings
let g:session_autosave='yes'
let g:session_autoload='yes'
let g:session_default_overwrite=1
let g:session_autosave_periodic='1'
let g:session_autosave_silent=1
let g:session_default_to_last=1
let g:session_command_aliases=1
let g:session_persist_colors=0
let g:session_persist_font=0

nmap <F8> :TagbarToggle<CR>

" let g:solarized_termcolors=256
" let g:solarized_termcolors=16
" colorscheme solarized
" colorscheme peaksea
colorscheme molokai

" close current buffer but do not close window
:nnoremap <Leader>z :Bdelete<CR>

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


au BufNewFile,BufRead *.js, *.html, *.css, *.yml. *.yaml
    \ set tabstop=2
    \ set softtabstop=2
    \ set shiftwidth=2
