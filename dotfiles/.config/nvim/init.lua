local u = require 'utils'
local a = vim.api
local o = vim.opt
local ol = vim.opt_local

vim.g.mapleader = ','
vim.g.python3_host_prog = '$WORKON_HOME/nvim/bin/python3'
vim.g.vimsyn_embed = 'l'

require 'impatient'
-- ~/.config/nvim/lua/plugins.lua
require 'plugins'

local function set_options()
    o.paste = false
    o.clipboard = 'unnamedplus'
    o.mouse = 'a'

    o.number = true
    o.relativenumber = true
    o.textwidth = 0
    o.wrap = true
    o.linebreak = true
    o.foldmethod = 'expr'
    o.foldexpr = 'nvim_treesitter#foldexpr()'
    o.foldlevelstart = 99
    o.foldnestmax = 10

    o.list = false
    o.listchars = { extends = '#', precedes = '#', tab = '-->', space = '⋅' }
    o.fillchars = { vert = '│' }
    o.diffopt:append { 'vertical', 'indent-heuristic', 'algorithm:patience' }

    o.showtabline = 0 -- do not disply tab on the top os the screen
    o.laststatus = 3 -- global status line
    o.ruler = true -- disply line/col in status bar
    o.autoread = true

    o.startofline = true -- scrolling puts cursor on first non blank character
    o.scrolloff = 15 -- cursor margins

    -- search settings
    o.hlsearch = false
    o.incsearch = true
    o.ignorecase = true
    o.smartcase = true
    o.inccommand = 'split'

    -- notes:
    -- * when using spaces for indentation, tabstop is not important
    -- * when using tabs for indentation, set noet sw=0 ts=ident_width
    -- * sts > 0 is for special cases (typically do not need to bother)
    -- * :retab may be handy to convert tabs <-> spaces
    -- * I use spaces for indentation most of the times thus sw value is most important
    o.expandtab = true -- Insert spaces when TAB is pressed.
    o.shiftwidth = 4 -- Indentation amount for < and > commands.
    o.shiftround = true -- Does nothing when shiftwidth=0
    o.smartindent = true
    o.softtabstop = -1 -- Ignore tabstop, use shiftwidth value

    o.splitbelow = false
    o.splitright = true -- Vertical split to right of current.
    o.previewheight = 20

    -- http://stackoverflow.com/questions/102384/using-vims-tabs-like-buffers
    o.hidden = true

    -- Enable persistent undo so that undo history persists across vim sessions
    o.undofile = true

    o.backup = false
    o.swapfile = false

    -- Spelling
    o.spelllang = 'en_us'
    o.spellcapcheck = ''

    -- tab completion in comand mode
    o.wildmode = { 'longest:full', 'full' }
    o.wildmenu = true
    o.wildoptions = { 'pum', 'tagfile' }
    o.wildignore:append { '*/.git/*', '*.pyc', '*.swp', '*.o' }
    o.wildignorecase = true
    o.path:append { '**' }

    o.completeopt = { 'menuone', 'noinsert', 'noselect' }

    o.showmode = false
    o.showcmd = true

    o.signcolumn = 'yes'

    -- mainly for tagbar hilight
    o.updatetime = 500

    o.shortmess:append 'Wc'

    o.termguicolors = true
    -- just in case when colorsheme is not installed
    vim.cmd [[hi MatchParen  cterm=underline ctermbg=0 gui=underline guibg=bg]]
end

local function set_mappings()
    local map = vim.keymap.set
    local opts = { noremap = true, silent = false }
    local function extend(d1, d2)
        return vim.tbl_extend('force', d1, d2)
    end

    -- bad habit
    for _, arrow in ipairs { '<Left>', '<Right>', '<Up>', '<Down>' } do
        map('c', arrow, '<nop>', opts)
    end

    -- more tmux like behavior
    map('n', '<c-w>c', '<cmd>tabedit %<cr>', opts)

    -- do not override unnamed register when pasting over
    map('x', 'p', [['pgv"'.v:register.'y']], extend(opts, { expr = true }))

    -- update history on certain input events
    -- note: careful, this is not cool when using macro..
    -- if there was any way to make this enabled but not when running macro..
    map('i', '<c-u>', '<c-g>u<c-u>', opts)
    map('i', '<c-w>', '<c-g>u<c-w>', opts)
    map('i', '<c-r>', '<c-g>u<c-r>', opts)
    -- map('i', '<Space>', '<Space><c-g>u', opts)

    map('v', '<', '<gv', opts)
    map('v', '>', '>gv', opts)

    -- Visual linewise up and down by default (and use gj gk to go quicker)
    map('n', 'j', 'gj', opts)
    map('n', 'k', 'gk', opts)

    map('c', '<c-n>', '<down>', opts)
    map('c', '<c-p>', '<up>', opts)
    map('c', '<c-a>', '<home>', opts)

    for _, nav in ipairs { 'n', 'N', '*', '#', 'g*', 'g#', 'gd', '<c-]' } do
        map('n', nav, nav .. 'zt', opts)
    end
    map('n', 'G', 'Gzz', opts)

    -- inoremap <expr> <tab>   pumvisible() ? "\<c-n>" : "\<tab>"
    -- inoremap <expr> <s-tab> pumvisible() ? "\<c-p>" : "\<s-Tab>"

    map('n', '<leader>ds', '<cmd>windo diffthis<cr>', opts)
    map('n', '<leader>de', '<cmd>windo diffoff<cr>', opts)

    map(
        'n',
        '<leader>z',
        [[<cmd>let @z=expand("<cword>")<cr>q:i%s/\C\v<<esc>"zpa>//g<esc>hi]],
        opts
    )
    map('n', '<leader>e', '<cmd>e $MYVIMRC<cr>', opts)
    map('n', '<leader>q', '<cmd>botright copen 10<cr>', opts)
    map('n', '<leader>W', '<cmd>%s/s+$//e<cr>', opts)
end

local function set_filetype_settings()
    local augroup = a.nvim_create_augroup('filetype_settings', { clear = true })
    local function f(pattern, callback)
        a.nvim_create_autocmd('FileType', {
            group = augroup,
            pattern = pattern,
            callback = callback,
        })
    end

    f('html,xhtml,css,yaml', function()
        ol.shiftwidth = 2
    end)
    f('gitcommit', function()
        ol.spell = true
        ol.textwidth = 72
        ol.colorcolumn = '+1'
    end)
    f('vim', function()
        ol.foldmethod = 'marker'
        ol.shiftwidth = 2
    end)
    f('go', function()
        ol.expandtab = false
        ol.shiftwidth = 0
        ol.tabstop = 4
    end)
    f('haskell', function()
        ol.shiftwidth = 2
        ol.tags:append 'codex.tags;/'
    end)
    f('c,cpp', function()
        ol.shiftwidth = 2
        ol.tags:append '~/.tags/c.tags'
        local ft = a.nvim_buf_get_option(0, 'filetype')
        if ft == 'c' then
            ol.path = u.get_gcc_include_paths()
        elseif ft == 'cpp' then
            ol.path = u.get_gcc_include_paths 'cpp'
        end
    end)
    f('sql', function()
        ol.commentstring = '--%s'
        ol.shiftwidth = 2
    end)
    f('python', function()
        a.nvim_buf_create_user_command(0, 'A', u.pytest_file_toggle, {})
    end)
    f('markdown', function()
        ol.spell = true
    end)
    f('qf,help,man', function()
        vim.keymap.set('n', 'q', '<c-w>q', { noremap = true, silent = true, buffer = true })
        local ft = a.nvim_buf_get_option(0, 'filetype')
        if ft == 'help' or ft == 'man' then
            ol.signcolumn = 'no'
        end
    end)
    f('tex', function()
        ol.shiftwidth = 2
        ol.spell = true
        ol.wrap = true
    end)
    f('vifm', function()
        ol.syntax = vim
        ol.commentstring = '"%s'
    end)
    f('coq', function()
        ol.shiftwidth = 2
        ol.commentstring = '(*%s*)'
    end)
end

local function set_particular_file_settings()
    local augroup = a.nvim_create_augroup('file_settings', { clear = true })
    local function f(pattern, callback)
        a.nvim_create_autocmd('BufRead', {
            group = augroup,
            pattern = pattern,
            callback = callback,
        })
    end

    f('*/.zshrc', function()
        ol.foldmethod = 'marker'
    end)
    f('*/.aliases', function()
        ol.filetype = 'sh'
    end)
end

local function set_cmd_nosmartcase()
    local augroup = a.nvim_create_augroup('nosmartcase_cmd', { clear = true })
    a.nvim_create_autocmd('CmdlineEnter', {
        group = augroup,
        pattern = '*',
        callback = function()
            vim.o.smartcase = false
        end,
    })
    a.nvim_create_autocmd('CmdlineLeave', {
        group = augroup,
        pattern = '*',
        callback = function()
            vim.o.smartcase = true
        end,
    })
end

local function set_smartnumbers()
    local augroup = a.nvim_create_augroup('smartnumbers', { clear = true })
    a.nvim_create_autocmd({ 'InsertEnter', 'WinLeave' }, {
        group = augroup,
        pattern = '*',
        callback = function()
            if ol.buftype:get() == '' then
                ol.relativenumber = false
            end
        end,
    })
    a.nvim_create_autocmd({ 'InsertLeave', 'WinEnter' }, {
        group = augroup,
        pattern = '*',
        callback = function()
            if ol.buftype:get() == '' then
                ol.relativenumber = true
            end
        end,
    })
end

local function set_visual_yank()
    a.nvim_create_autocmd('TextYankPost', {
        pattern = '*',
        callback = function()
            pcall(function()
                vim.highlight.on_yank { higroup = 'IncSearch', timeout = 250, on_visual = false }
            end)
        end,
    })
end

local function set_terminal()
    local augroup = a.nvim_create_augroup('terminal_custom', { clear = true })
    a.nvim_create_autocmd({ 'BufWinEnter', 'WinEnter', 'FocusGained' }, {
        group = augroup,
        pattern = 'term://*',
        command = 'startinsert',
    })
    a.nvim_create_autocmd({ 'BufLeave', 'FocusLost' }, {
        group = augroup,
        pattern = 'term://*',
        command = 'stopinsert',
    })
    -- note: TermOpen is fired after all Win/Buf events
    -- filename and buftype are not set before TermOpen event
    a.nvim_create_autocmd('TermOpen', {
        group = augroup,
        pattern = '*',
        callback = function()
            ol.number = false
            ol.relativenumber = false
            ol.signcolumn = 'no'
        end,
    })
    a.nvim_create_autocmd('TermClose', {
        group = augroup,
        pattern = '*',
        callback = function()
            if vim.v.event.status == 0 then
                a.nvim_buf_delete(0, { force = true })
            end
        end,
    })
    -- TODO: fix pageup
    -- vim.keymap.set('t', '<pageup>', [[<c-\><c-n><pageup>]], { noremap = true })
end

local function set_diagnostics()
    vim.diagnostic.config {
        underline = false,
        virtual_text = false,
        severity_sort = true,
    }
    vim.cmd [[
    sign define DiagnosticSignError text=✖ texthl=DiagnosticSignError linehl= numhl=
    sign define DiagnosticSignWarn text=⚠ texthl=DiagnosticSignWarn linehl= numhl=
    sign define DiagnosticSignInfo text=ℹ texthl=DiagnosticSignInfo linehl= numhl=
    sign define DiagnosticSignHint text=💡 texthl=DiagnosticSignHint linehl= numhl=
    ]]
end

set_options()
set_mappings()
set_filetype_settings()
set_particular_file_settings()
set_cmd_nosmartcase()
set_smartnumbers()
set_visual_yank()
set_diagnostics()
set_terminal()
