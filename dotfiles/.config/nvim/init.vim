" neovim-npython installations
let g:python3_host_prog = '$WORKON_HOME/nvim/bin/python3'

let mapleader=","

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
" works with some bugs
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
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
    \| setl tags+=~/.tags/c.tags
  au FileType c   let &l:path=luaeval('require("utils").get_gcc_include_paths()')
  au FileType cpp let &l:path=luaeval('require("utils").get_gcc_include_paths("cpp")')
  au FileType sql setl cms=--%s ts=2 sts=2 sw=2
  " au FileType asm setl
  au FileType python command! -bang A call PytestFileToggle()
  au FileType markdown setl spell
  au FileType qf nnoremap <silent> <buffer> q :cclose<cr>:lclose<cr>
  au FileType help,man setl signcolumn=no | nnoremap <silent> <buffer> q :q<cr>
  au FileType cmake setl cms=#%s
  au FileType tex setl ts=2 sts=2 sw=2 spell wrap
  au FileType vifm setl syntax=vim cms=\"%s
  au FileType coq setl cms=(*%s*) ts=2 sts=2 sw=2
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

" just in case when colorsheme is not installed
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
sign define DiagnosticSignWarning text=⚠ texthl=DiagnosticSignWarning linehl= numhl=
sign define DiagnosticSignInformation text=ℹ texthl=DiagnosticSignInformation linehl= numhl=
sign define DiagnosticSignHint text=💡 texthl=DiagnosticSignHint linehl= numhl=
" }}}
