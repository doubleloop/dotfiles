" neovim-npython installations
let g:python3_host_prog = '$WORKON_HOME/nvim/bin/python3'

let mapleader=","
" Plugins {{{
" if !filereadable(stdpath('data').'/site/autoload/plug.vim')
"   silent! exe '!curl -fLo '.stdpath('data').'/site/autoload/plug.vim --create-dirs '.
"       \'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
"   function! PrepareVim()
"     source $MYVIMRC
"     PlugInstall --sync
"     source $MYVIMRC
"   endfunc
"   command! Prep :call PrepareVim()
if 1
lua require('plugins')
else
call plug#begin(stdpath('data').'/plugged')
Plug 'wikitopian/hardmode'
Plug 'takac/vim-hardtime'
let g:hardtime_default_on=0
let g:hardtime_allow_different_key = 1

Plug 'tpope/vim-repeat'    " Fix '.' key on some plugins
Plug 'tpope/vim-surround'  " Must have surround functionality
Plug 'terrortylor/nvim-comment'
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

Plug 'Pocco81/AutoSave.nvim'

Plug 'folke/which-key.nvim'
Plug 'tversteeg/registers.nvim', { 'branch': 'main' }

Plug 'junegunn/fzf', { 'dir': '~/src/fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
let g:fzf_command_prefix = 'Fzf'
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.8 } }
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
Plug 'ojroques/nvim-lspfuzzy'

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

Plug 'vigoux/LanguageTool.nvim'
let g:languagetool_server_jar='$HOME/.local/share/languagetool/languagetool-server.jar'

" Mirroring files on various remote hosts
Plug 'zenbro/mirror.vim'
" push/pull to remote host (mirror plugin)
nnoremap <leader>rr :w<cr>:MirrorPush<cr>
nnoremap <leader>rd :MirrorDiff<cr>
nnoremap <leader>rl :MirrorReload<cr>

Plug 'troydm/zoomwintab.vim'
let g:zoomwintab_remap = 0
nnoremap <silent> <c-w>z :ZoomWinTabToggle<cr>
vnoremap <silent> <c-w>z <c-\><c-n>:ZoomWinTabToggle<cr>gv

" Plug 'Shougo/vinarise.vim' " hex editor

" Various text objects
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-line' " l

Plug 'vim-scripts/ReplaceWithRegister' " gr
Plug 'AndrewRadev/splitjoin.vim'       " gJ gS

Plug 'lewis6991/gitsigns.nvim'

Plug 'kyazdani42/nvim-tree.lua'
nnoremap <a-1> :NvimTreeToggle<cr>
let g:nvim_tree_indent_markers = 1
let g:nvim_tree_follow = 1
Plug 'stsewd/gx-extended.vim'

" Help alligning text
Plug 'godlygeek/tabular'
" Plug 'dhruvasagar/vim-table-mode'

" Improved sessions
Plug 'rmagatti/auto-session'

Plug 'moll/vim-bbye'

Plug 'vimwiki/vimwiki', { 'branch': 'dev' }
let g:vimwiki_list = [{'path': '~/workspace/vimwiki'}]

" Eclipse like autoopening of quotes/parenthesis
Plug 'windwp/nvim-autopairs'
Plug 'windwp/nvim-ts-autotag' " html tags autoclose

" Plug 'kien/rainbow_parentheses.vim'
Plug 'RRethy/vim-illuminate'
let g:Illuminate_delay = 500
let g:Illuminate_ftblacklist = ['LuaTree', 'nerdtree']

" Panel with tags
Plug 'majutsushi/tagbar'
let g:tagbar_autoclose = 0
let g:tagbar_sort = 0
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

Plug 'mhartington/formatter.nvim'

" Python
Plug 'Vimjas/vim-python-pep8-indent', { 'for': ['python', 'python3']}
" Plug 'tmhedberg/SimpylFold',          { 'for': ['python', 'python3']}
" Plug 'bfredl/nvim-ipy',             { 'do': ':UpdateRemotePlugins' }
" let g:nvim_ipy_perform_mappings = 0
Plug 'BurningEther/iron.nvim',      { 'do': ':UpdateRemotePlugins' }
let g:iron_map_defaults = 0
nmap <F5> <Plug>(iron-send-line)
vmap <F5> <Plug>(iron-visual-send)
nmap <F8> <Plug>(iron-interrupt)

function! BuildComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    !cargo build --release
  endif
endfunction
Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }
let g:markdown_composer_open_browser = 0

Plug 'momota/junos.vim',              { 'for': 'junos' }
Plug 'let-def/vimbufsync'
Plug 'the-lambda-church/coquille',    { 'branch': 'pathogen-bundle' }

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

Plug 'neovim/nvim-lspconfig'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'

Plug 'kyazdani42/nvim-web-devicons'
Plug 'hoob3rt/lualine.nvim'

Plug 'norcalli/nvim-colorizer.lua'

Plug 'tanvirtin/monokai.nvim'

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
" works with some bugs
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldlevelstart=99
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

" fix treesitter
nnoremap <leader><leader> <cmd>write <bar> edit <bar> TSBufEnable highlight<cr>
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

inoremap <expr> <tab>   pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr> <s-tab> pumvisible() ? "\<c-p>" : "\<s-Tab>"

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
  au FileType go setl noet ts=4 sts=4 sw=4
  au FileType haskell
    \  setl tags+=codex.tags;/
    \| setl ts=2 sts=2 sw=2
  au FileType c,cpp
    \  setl cms=//%s
    \| setl ts=2 sts=2 sw=2
    \| setl path=.,/usr/lib/gcc/x86_64-linux-gnu/10/include,/usr/local/include,/usr/lib/gcc/x86_64-linux-gnu/10/include-fixed,/usr/include/x86_64-linux-gnu,/usr/include,**
    \| setl tags+=~/.tags/c.tags
  au FileType sql setl cms=--%s ts=2 sts=2 sw=2
  " au FileType asm setl
  au FileType python command! -bang A call PytestFileToggle()
  au FileType markdown setl spell
  au FileType qf nnoremap <silent> <buffer> q :cclose<cr>:lclose<cr>
  au FileType help,man setl signcolumn=no | nnoremap <silent> <buffer> q :q<cr>
  au FileType cmake setl cms=#%s
  au FileType tex setl ts=2 sts=2 sw=2 spell wrap
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
au TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=250, on_visual=false}

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
  hi DiffAdd        guibg=#3d5213
  hi DiffDelete     guifg=#575b61  guibg=#2d2e27
  hi DiffText       guibg=#523f16
  hi DiffChange     guibg=#2d2e27

  hi diffAdded      guifg=#A6E22D ctermfg=DarkGreen
  hi diffRemoved    guifg=#F92772 ctermfg=DarkRed
  hi diffFile       guifg=#66D9EF ctermfg=White
  hi diffIndexLine  guifg=#66D9EF ctermfg=White
  hi diffLine       guifg=#66D9EF ctermfg=White
  hi diffSubname    guifg=White   ctermfg=White
  hi CheckedByCoq   guibg=#313337
  hi SentToCoq      guibg=#313337

  " underline color support is not yet working in allacritty
  " if it will then uncomment this
  " hi SpellBad gui=undercurl guisp=#e73c50 guifg=None
  hi SpellBad gui=undercurl guisp=#e73c50 guifg=#e73c50

  let l:sign_column_guibg = synIDattr(synIDtrans(hlID('SignColumn')), 'bg', 'gui')
  let l:sign_column_ctermbg = synIDattr(synIDtrans(hlID('SignColumn')), 'bg', 'cterm')
  let l:spell_bad_guifg = synIDattr(synIDtrans(hlID('SpellBad')), 'sp', 'gui')
  let l:spell_bad_ctermfg = synIDattr(synIDtrans(hlID('SpellBad')), 'fg', 'cterm')

  exec 'hi LspDiagnosticsSignError ' .
          \' guifg='    . l:sign_column_guibg
          \' ctermfg='  . l:sign_column_ctermbg
          \' guibg='    . l:sign_column_guibg .
          \' ctermbg='  . l:sign_column_ctermbg
  exec 'hi LspDiagnosticsSignWarning ctermfg=208 guifg=#FD9720' .
          \' guibg='    . l:sign_column_guibg .
          \' ctermbg='  . l:sign_column_ctermbg
  hi link LspDiagnosticsSignInformation LspDiagnosticsSignWarning
  exec 'hi LspDiagnosticsSignHint ctermfg=208 guifg=#E6DB74' .
          \' guibg='    . l:sign_column_guibg .
          \' ctermbg='  . l:sign_column_ctermbg

  " used by document_highlight
  hi link LspReferenceText CursorLine
  hi link LspReferenceWrite CursorLine
  hi link LspReferenceRead CursorLine

  exec 'hi GitSignsAdd guifg=#A6E22D ctermfg=DarkGreen' .
        \' guibg='.l:sign_column_guibg .' ctermbg='.l:sign_column_ctermbg
  exec 'hi GitSignsChange guifg=#FD9720 ctermfg=208'.
        \' guibg='.l:sign_column_guibg .' ctermbg='.l:sign_column_ctermbg
  exec 'hi GitSignsDelete guifg=#F92772 ctermfg=DarkRed' .
        \' guibg='.l:sign_column_guibg .' ctermbg='.l:sign_column_ctermbg

endfunction
au ColorScheme * call ColorCustomizations()

silent! colorscheme monokai
" }}}

" LSP {{{
" call lsp#set_log_level("debug")

sign define LspDiagnosticsSignError text=✖ texthl=LspDiagnosticsSignError linehl= numhl=
sign define LspDiagnosticsSignWarning text=⚠ texthl=LspDiagnosticsSignWarning linehl= numhl=
sign define LspDiagnosticsSignInformation text=ℹ texthl=LspDiagnosticsSignInformation linehl= numhl=
sign define LspDiagnosticsSignHint text=💡 texthl=LspDiagnosticsSignHint linehl= numhl=
nnoremap <silent><a-d> <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>
nnoremap <silent>dn <cmd>lua vim.lsp.diagnostic.goto_next()<cr>
nnoremap <silent>dp <cmd>lua vim.lsp.diagnostic.goto_prev()<cr>

augroup LSP
  au!
  au Filetype rust,python,c,cpp,lua,tex,bib,sh,bash
    \  setl omnifunc=v:lua.vim.lsp.omnifunc
    \| inoremap <expr> <c-n> pumvisible() ? '<c-n>' : ''
    \| nnoremap <silent><c-t> <c-o>zt
    \| inoremap <silent><a-s>     <cmd>lua vim.lsp.buf.signature_help()<cr>
    \| nnoremap <silent>K         <cmd>lua vim.lsp.buf.hover()<cr>
    \| nnoremap <silent><leader>n <cmd>lua vim.lsp.buf.references()<cr>
    \| nnoremap <silent><leader>r <cmd>lua vim.lsp.buf.rename()<cr>
    \| nnoremap <silent><leader>= <cmd>lua vim.lsp.buf.formatting()<cr>
    \| vnoremap <silent><leader>= <esc><cmd>lua vim.lsp.buf.range_formatting()<cr>
    \| nnoremap <silent><c-]>     <cmd>lua vim.lsp.buf.definition()<cr>zt
    \| nnoremap <silent><leader>. <cmd>lua vim.lsp.buf.code_action()<cr>
    \| vnoremap <silent><leader>. <cmd>lua vim.lsp.buf.range_code_action()<cr>
  au Filetype python,lua
    \  nnoremap <silent><leader>= <cmd>Format<cr>
  au Filetype c,cpp,rust,go
    \  nnoremap <silent>gd        <cmd>lua vim.lsp.buf.declaration()<cr>
  au Filetype c,cpp
    \ cnoreabbrev A ClangdSwitchSourceHeader
  " au CursorHold <buffer> lua vim.lsp.buf.document_highlight()
  " au CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
  " au CursorMoved <buffer> lua vim.lsp.buf.clear_references()
  nnoremap <silent><c-n> <cmd>lua require"illuminate".next_reference{wrap=true}<cr>
  nnoremap <silent><c-p> <cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<cr>
augroup end
" }}}
