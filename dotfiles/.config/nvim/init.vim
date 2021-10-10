let mapleader=","
let g:python3_host_prog = '$WORKON_HOME/nvim/bin/python3'
let g:vimsyn_embed = 'l'

" ~/.config/nvim/lua/plugins.lua
lua require('plugins')

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
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr() " works with some bugs
set foldlevelstart=99
set foldnestmax=10

set nolist
set listchars=extends:#,precedes:#,tab:-->,space:⋅
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

" notes:
" * when using spaces for indentation, tabstop is not important
" * when using tabs for indentation, set noet sw=0 ts=ident_width
" * sts > 0 is for special cases (typically do not need to bother)
" * :retab may be handy to convert tabs <-> spaces
" * I use spaces for indentation most of the times thus sw value is most important
set expandtab      " Insert spaces when TAB is pressed.
set shiftwidth=4   " Indentation amount for < and > commands.
set shiftround     " Does nothing when shiftwidth=0
set smartindent
set softtabstop=-1 " Ignore tabstop, use shiftwidth value

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

set termguicolors
" just in case when colorsheme is not installed
hi MatchParen  cterm=underline ctermbg=0 gui=underline guibg=bg
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

" fix treesitter
nnoremap <leader><leader> <cmd>write <bar> edit <bar> TSBufEnable highlight<cr>

nnoremap n nzt
nnoremap N Nzt
nnoremap * *zt
nnoremap # #zt
nnoremap g* g*zt
nnoremap g# g#zt
nnoremap gd gdzt
nnoremap <c-]> <c-]>zt
nnoremap <c-t> <c-t>zt
nnoremap <c-o> <c-o>zt
nnoremap G Gzz

inoremap <expr> <tab>   pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr> <s-tab> pumvisible() ? "\<c-p>" : "\<s-Tab>"

noremap <leader>ds <cmd>windo diffthis<cr>
noremap <leader>de <cmd>windo diffoff<cr>
noremap <leader>dd <cmd>Gdiffsplit<cr>

nnoremap <leader>z <cmd>let @z=expand("<cword>")<cr>q:i%s/\C\v<<esc>"zpa>//g<esc>hi
nnoremap <leader>e <cmd>e $MYVIMRC<cr>
nnoremap <silent> <leader>q <cmd>botright copen 10<cr>
nnoremap <leader>W <cmd>%s/\s\+$//e<cr>

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
  au FileType html,xhtml,css,yaml setl sw=2
  au FileType gitcommit setl spell
  au FileType vim setl fdm=marker sw=2
  au FileType go setl noet sw=0 ts=4
  au FileType haskell
    \  setl sw=2
    \| setl tags+=codex.tags;/
  au FileType c,cpp
    \  setl sw=2
    \| setl tags+=~/.tags/c.tags
  au FileType c   let &l:path=luaeval('require("utils").get_gcc_include_paths()')
  au FileType cpp let &l:path=luaeval('require("utils").get_gcc_include_paths("cpp")')
  au FileType sql setl cms=--%s sw=2
  " au FileType asm setl
  au FileType python command! -bang A call PytestFileToggle()
  au FileType markdown setl spell
  au FileType qf nnoremap <silent> <buffer> q :cclose<cr>:lclose<cr>
  au FileType help,man setl signcolumn=no | nnoremap <silent> <buffer> q :q<cr>
  au FileType tex setl sw=2 spell wrap
  au FileType vifm setl syntax=vim cms=\"%s
  au FileType coq setl cms=(*%s*) sw=2
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
" TODO: when switching focus from other tmux window, terminal is is not in insert
" mode
function! TerminalSet()
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
tnoremap <pageup> <c-\><c-n><pageup>
tnoremap <pagedown> <c-\><c-n><pagedown>
" }}}

" Diagnostics {{{
lua << EOF
vim.diagnostic.config {
    underline = false,
    virtual_text = false,
    severity_sort = true,
}
EOF
sign define DiagnosticSignError text=✖ texthl=DiagnosticSignError linehl= numhl=
sign define DiagnosticSignWarn text=⚠ texthl=DiagnosticSignWarn linehl= numhl=
sign define DiagnosticSignInfo text=ℹ texthl=DiagnosticSignInfo linehl= numhl=
sign define DiagnosticSignHint text=💡 texthl=DiagnosticSignHint linehl= numhl=
" }}}
