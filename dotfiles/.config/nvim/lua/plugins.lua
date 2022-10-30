local function bootstrap()
    local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
    if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
        vim.fn.system {
            'git',
            'clone',
            '--depth',
            '1',
            'https://github.com/wbthomason/packer.nvim',
            install_path,
        }
        vim.cmd 'packadd packer.nvim'
    end
end

if not pcall(bootstrap) then
    print 'Failed to bootstrap packer!'
    do
        return
    end
end

-- TODO: fix bootstrap
require 'impatient'

local use = require('packer').use

local function packer_startup_fun()
    use 'wbthomason/packer.nvim'
    use 'lewis6991/impatient.nvim'

    use { 'wikitopian/hardmode', fn = { 'ToggleHardMode', 'HardMode', 'EasyMode' } }
    use {
        'takac/vim-hardtime',
        cmd = { 'HardTimeOn', 'HardTimeOff', 'HardTimeToggle' },
        setup = function()
            vim.g.hardtime_default_on = 0
            vim.g.hardtime_allow_different_key = 1
        end,
    }
    use 'tpope/vim-repeat' -- Fix '.' key on some plugins
    use 'tpope/vim-surround' -- Must have surround functionality
    use {
        'numToStr/Comment.nvim',
        after = 'nvim-ts-context-commentstring',
        config = function()
            local cu = require 'Comment.utils'
            local tcu = require 'ts_context_commentstring.utils'
            local tci = require 'ts_context_commentstring.internal'
            require('Comment').setup {
                -- https://github.com/numToStr/Comment.nvim#pre-hook
                pre_hook = function(ctx)
                    local location = nil
                    if ctx.ctype == cu.ctype.block then
                        location = tcu.get_cursor_location()
                    elseif ctx.cmotion == cu.cmotion.v or ctx.cmotion == cu.cmotion.V then
                        location = tcu.get_visual_start_location()
                    end
                    return tci.calculate_commentstring {
                        key = ctx.ctype == cu.ctype.line and '__default' or '__multiline',
                        location = location,
                    }
                end,
            }
        end,
    }
    use {
        'tpope/vim-fugitive', -- git integration
        config = function()
            local opts = { noremap = true, silent = false }
            vim.keymap.set('n', '<leader>dd', '<cmd>Gdiffsplit<cr>', opts)
        end,
    }
    use { 'tpope/vim-rhubarb', after = 'vim-fugitive' } -- gihtub Gbrowse
    use { 'tommcdo/vim-fubitive', after = 'vim-fugitive' } -- bitbucket Gbrowse
    use {
        'tpope/vim-sleuth', -- guess ts heuristically
        cmd = { 'Sleuth' },
        setup = function()
            vim.g.sleuth_automatic = 0
        end,
    }
    use {
        'numToStr/Navigator.nvim',
        config = function()
            local nv = require 'Navigator'
            nv.setup {
                disable_on_zoom = true,
            }
            local maps = {
                ['<a-h>'] = nv.left,
                ['<a-j>'] = nv.down,
                ['<a-k>'] = nv.up,
                ['<a-l>'] = nv.right,
                ['<a-\\>'] = nv.previous,
            }
            local opts = { noremap = true, silent = true }
            for m, fun in pairs(maps) do
                vim.keymap.set({ 'n', 'v', 'c', 't' }, m, fun, opts)
                vim.keymap.set('i', m, function()
                    vim.cmd 'stopinsert'
                    fun()
                end, opts)
            end
        end,
    }
    use {
        'Pocco81/auto-save.nvim',
        config = function()
            require('auto-save').setup {
                enabled = true,
                trigger_events = { 'InsertLeave', 'TextChanged', 'FocusLost', 'BufHidden', 'ExitPre' },
                write_all_buffers = false,
                debounce_delay = 1000,
                execution_message = {
                    enabled = false,
                },
                condition = function(buf)
                    if vim.fn.getbufvar(buf, "&modifiable") ~= 1 then
                        return false
                    end
                    local bt = vim.fn.getbufvar(buf, "&buftype")
                    if bt == "nofile" or bt == "nowrite" or bt == "prompt" then
                        return false
                    end
                    return true
                end,
            }
        end,
    }
    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
            'kyazdani42/nvim-web-devicons',
        },
        config = function()
            local actions = require 'telescope.actions'
            local builtin = require 'telescope.builtin'

            local function custom_send_to_qflist(prompt_bufnr)
                actions.send_to_qflist(prompt_bufnr)
                vim.cmd [[botright copen]]
            end

            require('telescope').setup {
                defaults = {
                    mappings = {
                        i = {
                            ['<esc>'] = actions.close,
                            ['<C-q>'] = custom_send_to_qflist,
                        },
                        n = {
                            ['q'] = actions.close,
                        },
                    },
                    layout_config = {
                        horizontal = {
                            preview_width = 0.5,
                            width = 0.9,
                        },
                    },
                },
            }

            local open_files = function()
                local ok = pcall(builtin.git_files, {})
                if not ok then
                    builtin.find_files {}
                end
            end


            local opts = { noremap = true, silent = false }
            local maps = {
                ['<c-p>'] = open_files,
                ['<c-b>'] = builtin.buffers,
                ['<c-s-p>'] = builtin.commands,
                ['<c-/>'] = builtin.live_grep,
                ['<c-s-h>'] = builtin.help_tags,
                ['<c-s-r>'] = builtin.command_history,
                -- <c-m> does not work with tmux :(, https://github.com/tmux/tmux/issues/2705#issuecomment-841133549
                -- ['<c-m>'] = builtin.oldfiles,
                ['<c-s-m>'] = builtin.keymaps,
                ['<leader>p'] = open_files,
                ['<leader>b'] = builtin.buffers,
                ['<leader>m'] = builtin.oldfiles,
                ['<leader><c-r>'] = builtin.command_history,
                ['<a-e>'] = builtin.tags,
            }
            for m, fun in pairs(maps) do
                vim.keymap.set('n', m, fun, opts)
            end
        end,
    }
    use {
        'nvim-telescope/telescope-fzf-native.nvim',
        after = 'telescope.nvim',
        run = 'make',
        config = function()
            require('telescope').load_extension 'fzf'
        end,
    }
    use {
        'mileszs/ack.vim',
        config = function()
            if vim.fn.executable 'rg' then
                vim.g.ackprg = 'rg --vimgrep'
            elseif vim.fn.executalbe 'ag' then
                vim.g.ackprg = 'ag --vimgrep'
            end
        end,
    }
    use {
        -- todo: check out chipsenkbeil/distant.nvim
        'zenbro/mirror.vim',
        config = function()
            local opts = { noremap = true, silent = false }
            vim.keymap.set('n', '<leader>rr', '<cmd>w<cr><cmd>MirrorPush<cr>', opts)
            vim.keymap.set('n', '<leader>rd', '<cmd>MirrorDiff<cr>', opts)
            vim.keymap.set('n', '<leader>rl', '<cmd>MirrorReload<cr>', opts)
        end,
    }
    use {
        'troydm/zoomwintab.vim',
        keys = '<c-w>z',
        setup = function()
            vim.g.zoomwintab_remap = 0
        end,
        config = function()
            local opts = { noremap = true, silent = true }
            vim.keymap.set({ 'n', 'v' }, '<c-w>z', '<cmd>ZoomWinTabToggle<cr>', opts)
        end,
    }
    use {
        'kana/vim-textobj-line',
        requires = 'kana/vim-textobj-user',
    }
    use 'vim-scripts/ReplaceWithRegister' -- gr
    use 'AndrewRadev/splitjoin.vim' -- gJ gS
    use {
        'lewis6991/gitsigns.nvim',
        requires = 'nvim-lua/plenary.nvim',
        config = function()
            local gs = require 'gitsigns'
            gs.setup {
                on_attach = function(bufnr)
                    local opts = { buffer = bufnr }
                    for m, fun in
                        pairs {
                            ['<a-g>'] = gs.preview_hunk,
                            ['<leader>gh'] = gs.preview_hunk,
                            ['<leader>gu'] = gs.undo_stage_hunk,
                        }
                    do
                        vim.keymap.set('n', m, fun, opts)
                    end

                    for m, cmd in
                        pairs {
                            ['v <leader>gs'] = '<cmd>Gitsigns stage_hunk<cr>',
                            ['v <leader>gr'] = '<cmd>Gitsigns reset_hunk<cr>',
                        }
                    do
                        vim.keymap.set({ 'n', 'v' }, m, cmd, opts)
                    end

                    for m, cmd in
                        pairs {
                            [']c'] = "&diff ? ']c' : '<cmd>Gitsigns next_hunk<cr>'",
                            ['[c'] = "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<cr>'",
                        }
                    do
                        vim.keymap.set('n', m, cmd, vim.tbl_extend('force', opts, { expr = true }))
                    end
                end,
            }
        end,
    }
    use {
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons',
        keys = '<a-1>',
        cmd = { 'NvimTreeOpen' },
        setup = function()
            vim.g.nvim_tree_indent_markers = 1
        end,
        config = function()
            local nvt = require 'nvim-tree'
            nvt.setup {
                hijack_cursor = true,
                update_focused_file = { enable = true },
                update_cwd = true,
            }
            vim.keymap.set('n', '<a-1>', nvt.toggle, { noremap = true, silent = false })
        end,
    }
    -- use 'stsewd/gx-extended.vim'
    use 'godlygeek/tabular'
    use {
        'xolox/vim-session',
        requires = 'xolox/vim-misc',
        setup = function()
            vim.g.session_autosave = 'yes'
            vim.g.session_autoload = 'no'
            vim.g.session_default_overwrite = 1
            vim.g.session_autosave_periodic = 1
            vim.g.session_autosave_silent = 1
            vim.g.session_default_to_last = 1
            vim.g.session_command_aliases = 1
            vim.g.session_persist_colors = 0
            vim.g.session_persist_font = 0
            vim.g.session_directory = vim.fn.stdpath 'data' .. '/sessions'
        end,
        config = function()
            local opts = { noremap = true, silent = false }
            vim.keymap.set('n', '<leader>so', '<cmd>SessionOpen default<cr>', opts)
            vim.keymap.set('n', '<leader>S', '<cmd>SessionOpen<cr>', opts)
        end,
    }
    use 'famiu/bufdelete.nvim'
    use {
        'vimwiki/vimwiki',
        branch = 'dev',
        keys = '<leader>ww',
        setup = function()
            vim.g.vimwiki_list = { { path = '~/workspace/vimwiki' } }
        end,
    }
    use {
        'windwp/nvim-autopairs',
        config = function()
            local npairs = require 'nvim-autopairs'
            local Rule = require 'nvim-autopairs.rule'

            npairs.setup {
                check_ts = true,
            }
            npairs.add_rules {
                Rule("f'", "'", 'python'),
                Rule('f"', "'", 'python'),
                Rule("r'", "'", 'python'),
                Rule('r"', "'", 'python'),
            }

            vim.keymap.set('i', '<cr>', function()
                if vim.fn.pumvisible() ~= 0 then
                    return npairs.esc '<cr>'
                else
                    return npairs.autopairs_cr()
                end
            end, { expr = true, noremap = true })
        end,
    }
    use {
        'windwp/nvim-ts-autotag', -- html tags autoclose
        after = 'nvim-treesitter',
        config = function()
            require('nvim-ts-autotag').setup()
        end,
    }
    use {
        'RRethy/vim-illuminate',
        config = function()
            vim.g.Illuminate_delay = 500
            vim.g.Illuminate_ftblacklist = { 'LuaTree', 'nerdtree' }
        end,
    }
    use {
        'majutsushi/tagbar',
        keys = '<a-2>',
        setup = function()
            vim.g.tagbar_autoclose = 0
            vim.g.tagbar_sort = 0
            vim.g.tagbar_iconchars = { '▸', '▾' }
            vim.g.tagbar_type_haskell = {
                ctagsbin = 'hasktags',
                ctagsargs = '-x -c -o-',
                kinds = {
                    'm:modules:0:1',
                    'd:data: 0:1',
                    'd_gadt: data gadt:0:1',
                    't:type names:0:1',
                    'nt:new types:0:1',
                    'c:classes:0:1',
                    'cons:constructors:1:1',
                    'c_gadt:constructor gadt:1:1',
                    'c_a:constructor accessors:1:1',
                    'ft:function types:1:1',
                    'fi:function implementations:0:1',
                    'o:others:0:1',
                },
                sro = '.',
                kind2scope = {
                    m = 'module',
                    c = 'class',
                    d = 'data',
                    t = 'type',
                },
                scope2kind = {
                    module = 'm',
                    class = 'c',
                    data = 'd',
                    type = 't',
                },
            }
            vim.g.tagbar_type_rust = {
                ctagstype = 'rust',
                kinds = {
                    'T:types,type definitions',
                    'f:functions,function definitions',
                    'g:enum,enumeration names',
                    's:structure names',
                    'm:modules,module names',
                    'c:consts,static constants',
                    't:traits',
                    'i:impls,trait implementations',
                },
            }
        end,
        config = function()
            local opts = { noremap = true, silent = false }
            vim.keymap.set('n', '<a-2>', '<cmd>TagbarToggle<cr>', opts)
        end,
    }
    use {
        'mhartington/formatter.nvim',
        ft = { 'lua', 'python' },
        config = function()
            require('formatter').setup {
                logging = false,
                filetype = {
                    python = {
                        function()
                            return {
                                exe = 'yapf',
                                args = {},
                                stdin = true,
                            }
                        end,
                        function()
                            return {
                                exe = 'isort',
                                args = { '-q', '-' },
                                stdin = true,
                            }
                        end,
                    },
                    lua = {
                        function()
                            return {
                                exe = 'stylua',
                                args = {
                                    '--search-parent-directories',
                                    '-',
                                },
                                stdin = true,
                            }
                        end,
                    },
                },
            }
            a.nvim_create_autocmd('FileType', {
                pattern = 'python,lua',
                callback = function()
                    vim.keymap.set(
                        'n',
                        '<leader>=',
                        '<cmd>Format<cr>',
                        { noremap = true, buffer = true }
                    )
                end,
            })
        end,
    }
    use { 'Vimjas/vim-python-pep8-indent', ft = { 'python' } }
    use {
        'BurningEther/iron.nvim',
        setup = function()
            vim.g.iron_map_defaults = 0
            vim.g.iron_map_extended = 0
        end,
        config = function()
            local iron = require('iron').core
            iron.set_config {
                preferred = {
                    python = 'ipython',
                },
                repl_open_cmd = 'vsplit',
            }

            local opts = { noremap = false, silent = false }
            vim.keymap.set('n', '<F5>', iron.send_line, opts)
            vim.keymap.set('v', '<F5>', '<esc><cmd>lua require("iron").exec_visual()<cr>', opts)
        end,
    }
    use {
        'euclio/vim-markdown-composer',
        -- building is slow, better to call it manually when it is needed
        -- run = 'cargo build --release'
        setup = function()
            vim.g.markdown_composer_autostart = 0
        end,
    }

    use { 'momota/junos.vim', ft = 'junos' }
    use {
        'the-lambda-church/coquille',
        branch = 'pathogen-bundle',
        requires = 'let-def/vimbufsync',
        ft = 'coq',
        config = function()
            local opts = { noremap = true, silent = true }
            for m, cmd in
                pairs {
                    ['<leader>cc'] = '<cmd>CoqLaunch<cr>',
                    ['<leader>cq'] = '<cmd>CoqKill<cr>',
                    ['<leader><F5>'] = '<cmd>CoqToCursor<cr>',
                }
            do
                vim.keymap.set('n', m, cmd, opts)
            end
        end,
    }
    use 'rafamadriz/friendly-snippets'
    use {
        'L3MON4D3/LuaSnip',
        config = function()
            local t = function(str)
                return vim.api.nvim_replace_termcodes(str, true, true, true)
            end
            local ls = require 'luasnip'
            ls.config.set_config {
                history = true,
                updateevents = 'TextChanged,TextChangedI',
            }
            vim.keymap.set({ 'i', 's' }, '<TAB>', function()
                if vim.fn.pumvisible() ~= 0 then
                    vim.fn.feedkeys(t '<c-n>', 'n')
                    return true
                elseif ls.expand_or_jumpable() then
                    return ls.expand_or_jump()
                end
                vim.fn.feedkeys(t '<TAB>', 'n')
            end)
            vim.keymap.set({ 'i', 's' }, '<S-TAB>', function()
                if vim.fn.pumvisible() ~= 0 then
                    vim.fn.feedkeys(t '<c-p>', 'n')
                    return true
                elseif ls.jumpable(-1) then
                    return ls.jump(-1)
                end
            end)
            vim.keymap.set({ 'i', 's' }, '<c-j>', function()
                if ls.expand_or_jumpable() then
                    return ls.expand_or_jump()
                end
            end)
            vim.keymap.set({ 'i', 's' }, '<c-k>', function()
                if ls.jumpable(-1) then
                    return ls.jump(-1)
                end
            end)
            vim.keymap.set('i', '<c-l>', function()
                if ls.choice_active() then
                    ls.change_choice(1)
                end
            end)
            ls.snippets = {} -- custom snippets (some day maybe)
            require('luasnip.loaders.from_vscode').load()
        end,
    }
    use {
        'neovim/nvim-lspconfig',
        requires = 'RRethy/vim-illuminate',
        config = function()
            local lsp = require 'lspconfig'
            local tb = require 'telescope.builtin'
            local function on_attach_defaults(_, bufnr)
                vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
                vim.api.nvim_buf_set_option(bufnr, 'tagfunc', 'v:lua.vim.lsp.tagfunc')

                vim.keymap.set(
                    'i',
                    '<c-n>',
                    [[ pumvisible() ? '<c-n>' : '' ]],
                    { expr = true, noremap = true, buffer = bufnr }
                )

                local opts = { noremap = true, silent = true, buffer = bufnr }
                for m, v in
                    pairs {
                        ['gd'] = vim.lsp.buf.declaration,
                        ['gi'] = vim.lsp.buf.implementation,
                        -- ['<leader>n'] = vim.lsp.buf.references,
                        ['<leader>n'] = tb.lsp_references,
                        ['<c-k>'] = vim.lsp.buf.signature_help,
                        ['K'] = vim.lsp.buf.hover,
                        ['<leader>D'] = vim.lsp.buf.type_definition,
                        ['<leader>r'] = vim.lsp.buf.rename,
                        ['<leader>.'] = vim.lsp.buf.code_action,
                        ['<a-d>'] = vim.diagnostic.open_float,
                        ['[d'] = vim.diagnostic.goto_prev,
                        [']d'] = vim.diagnostic.goto_next,
                        ['<a-e>'] = tb.lsp_document_symbols,
                    }
                do
                    vim.keymap.set('n', m, v, opts)
                end

                vim.keymap.set('i', '<a-s>', vim.lsp.buf.signature_help, opts)

                local ft = vim.api.nvim_buf_get_option(bufnr, 'filetype')
                if ft ~= 'python' and ft ~= 'lua' then
                    vim.keymap.set('n', '<leader>=', vim.lsp.buf.formatting, opts)
                    vim.keymap.set('v', '<leader>=', vim.lsp.buf.range_formatting, opts)
                end
            end

            lsp.clangd.setup {
                cmd = { 'clangd-11', '--background-index' },
                on_attach = function(client, bufnr)
                    on_attach_defaults(client, bufnr)
                    require('illuminate').on_attach(client)
                    vim.cmd [[cnoreabbrev A ClangdSwitchSourceHeader]]
                end,
            }

            lsp.jedi_language_server.setup {
                on_attach = on_attach_defaults,
            }
            lsp.pyright.setup {
                settings = {
                    python = {
                        analysis = {
                            useLibraryCodeForTypes = false,
                        },
                    },
                },
            }
            for _, server in ipairs { 'rls', 'gopls', 'tsserver' } do
                lsp[server].setup {
                    on_attach = function(client, bufnr)
                        on_attach_defaults(client, bufnr)
                        require('illuminate').on_attach(client)
                    end,
                }
            end

            lsp.texlab.setup {
                on_attach = on_attach_defaults,
                settings = {
                    texlab = {
                        build = {
                            onSave = true,
                        },
                        forwardSearch = {
                            executable = 'zathura',
                            args = { '--synctex-forward', '%l:1:%f', '%p' },
                        },
                    },
                },
            }

            local sumneko_root_path = vim.fn.getenv 'HOME' .. '/src/lua-language-server'
            local sumneko_binary = sumneko_root_path .. '/bin/lua-language-server'

            local runtime_path = vim.split(package.path, ';')
            table.insert(runtime_path, 'lua/?.lua')
            table.insert(runtime_path, 'lua/?/init.lua')

            lsp.sumneko_lua.setup {
                cmd = { sumneko_binary, '-E', sumneko_root_path .. '/main.lua' },
                settings = {
                    Lua = {
                        runtime = {
                            -- Tell the language server which version of Lua you're using (LuaJIT in the case of Neovim)
                            version = 'LuaJIT',
                            -- Setup your lua path
                            path = runtime_path,
                        },
                        diagnostics = {
                            -- Get the language server to recognize the `vim` global
                            globals = { 'vim' },
                        },
                        workspace = {
                            -- Make the server aware of Neovim runtime files
                            library = vim.api.nvim_get_runtime_file('', true),
                        },
                        telemetry = {
                            -- Do not send telemetry data containing a randomized but unique identifier
                            enable = false,
                        },
                    },
                },
                on_attach = on_attach_defaults,
            }
        end,
    }
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function()
            require('nvim-treesitter.configs').setup {
                ensure_installed = {
                    'bash',
                    'python',
                    'c',
                    'cpp',
                    'cmake',
                    'go',
                    'rust',
                    'lua',
                    'vim',
                    'latex',
                    'bibtex',
                    'javascript',
                    'java',
                    'css',
                    'html',
                    'json',
                    'yaml',
                    'toml',
                    'rst',
                    'comment',
                    'http',
                },
                highlight = {
                    enable = true,
                },
                -- todo: try to make ctrl-k like in sublime text :D
                -- incremental_selection = {
                --     enable = true,
                --     init_selection = "gnn",
                -- },
                -- indent = {
                --     enable = true,
                -- },
            }
            -- fix treesitter
            vim.keymap.set(
                'n',
                '<leader><leader>',
                '<cmd>write <bar> edit <bar> TSBufEnable highlight<cr>',
                { noremap = true, silent = false }
            )
        end,
    }
    use {
        'nvim-treesitter/nvim-treesitter-textobjects',
        after = 'nvim-treesitter',
        config = function()
            require('nvim-treesitter.configs').setup {
                textobjects = {
                    select = {
                        enable = true,
                        keymaps = {
                            ['af'] = '@function.outer',
                            ['ac'] = '@class.outer',
                        },
                    },
                    move = {
                        enable = true,
                        goto_next_start = {
                            [']]'] = '@function.outer',
                            [']c'] = '@class.outer',
                        },
                        goto_next_end = {
                            [']['] = '@function.outer',
                            [']C'] = '@class.outer',
                        },
                        goto_previous_start = {
                            ['[['] = '@function.outer',
                            ['[c'] = '@class.outer',
                        },
                        goto_previous_end = {
                            ['[]'] = '@function.outer',
                            ['[C'] = '@class.outer',
                        },
                    },
                    -- todo: more elements could be swapped
                    swap = {
                        enable = true,
                        swap_next = {
                            ['g>'] = '@parameter.inner',
                        },
                        swap_previous = {
                            ['g<'] = '@parameter.inner',
                        },
                    },
                },
            }
        end,
    }
    use {
        'mizlan/iswap.nvim',
        config = function()
            vim.keymap.set('n', 'gs', function()
                require('iswap').iswap_with()
            end, { noremap = true, silent = false })
        end,
    }
    use {
        'nvim-treesitter/playground',
        after = 'nvim-treesitter',
        config = function()
            require('nvim-treesitter.configs').setup {
                playground = {
                    enable = true,
                    disable = {},
                    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
                    persist_queries = false, -- Whether the query persists across vim sessions
                },
            }
        end,
    }
    use {
        'JoosepAlviste/nvim-ts-context-commentstring',
        after = 'nvim-treesitter',
        config = function()
            require('nvim-treesitter.configs').setup {
                context_commentstring = {
                    enable = true,
                    enable_autocmd = false,
                },
            }
        end,
    }
    use {
        'hoob3rt/lualine.nvim',
        requires = 'kyazdani42/nvim-web-devicons',
        after = 'monokai.nvim',
        config = function()
            require('lualine').setup {
                options = {
                    theme = 'wombat',
                    icons_enabled = true,
                    section_separators = '',
                    component_separators = { '|', '|' },
                },
                sections = {
                    lualine_a = { 'mode' },
                    lualine_b = {},
                    lualine_c = { { 'filename', file_status = true, path = 1 } },
                    lualine_x = { 'fileformat', 'encoding', 'filetype' },
                    lualine_y = { 'progress' },
                    lualine_z = { 'location' },
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { 'filename' },
                    lualine_x = { 'location' },
                    lualine_y = {},
                    lualine_z = {},
                },
                extensions = { 'nvim-tree', 'fugitive', 'quickfix' },
            }
        end,
    }
    use {
        'norcalli/nvim-colorizer.lua',
        config = function()
            require('colorizer').setup()
        end,
    }
    use {
        'tanvirtin/monokai.nvim',
        setup = function()
            vim.api.nvim_set_option('termguicolors', true)
        end,
        config = function()
            local monokai = require 'monokai'
            local palette = monokai.classic
            monokai.setup {
                custom_hlgroups = {
                    SpellBad = {
                        style = 'undercurl',
                        fg = 'fg',
                        bg = 'bg',
                        sp = '#e73c50',
                    },
                    FoldColumn = {
                        fg = palette.base5,
                        bg = palette.base2,
                    },
                    diffFile = {
                        fg = palette.white,
                    },
                    diffIndexLine = {
                        fg = palette.white,
                    },
                    diffLine = {
                        fg = palette.aqua,
                    },
                    diffSubname = {
                        fg = palette.white,
                    },
                    DiffAdd = {
                        bg = '#254229',
                    },
                    DiffDelete = {
                        fg = palette.base5,
                        bg = '#272d30',
                    },
                    DiffText = {
                        bg = '#523f16',
                    },
                    DiffChange = {
                        bg = '#303336',
                    },
                    GitSignsAdd = {
                        fg = palette.green,
                        bg = palette.base2,
                    },
                    GitSignsDelete = {
                        fg = palette.pink,
                        bg = palette.base2,
                    },
                    GitSignsChange = {
                        fg = palette.orange,
                        bg = palette.base2,
                    },
                    CheckedByCoq = {
                        bg = '#313337',
                    },
                    SentToCoq = {
                        bg = '#313337',
                    },
                    TSConstructor = {
                        fg = palette.aqua,
                    },
                    TSConstant = {
                        fg = palette.purple,
                    },
                    TSFuncBuiltin = {
                        fg = palette.green,
                    },
                },
            }

            -- used by document_highlight
            vim.cmd [[ hi! link LspReferenceText CursorLine ]]
            vim.cmd [[ hi! link LspReferenceWrite CursorLine ]]
            vim.cmd [[ hi! link LspReferenceRead CursorLine ]]

            -- I do not like this overwrites so switch back to defaults
            vim.cmd [[ hi! link TelescopeNormal Normal ]]
            vim.cmd [[ hi! link TelescopeSelection Visual ]]
            vim.cmd [[ hi! link TelescopeSelectionCaret TelescopeSelection ]]
            vim.cmd [[ hi! link TelescopeMatching Special ]]
            vim.cmd [[ hi! link TelescopeMultiSelection Type ]]
        end,
    }
end

-- TODO: fix bootstrap
require('packer').startup {
    packer_startup_fun,
    config = {
        display = {
            open_fn = function()
                return require('packer.util').float { border = 'single' }
            end,
        },
        compile_path = vim.fn.stdpath 'config' .. '/lua/packer_compiled.lua',
    },
}

require 'packer_compiled'
