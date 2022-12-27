-- note: paths are done in linux specific way, this file will break on windows
-- todo: nvim path library ?!
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
        vim.cmd.packadd 'packer.nvim'
        return true
    end
    return false
end

local ok, _ = pcall(bootstrap)
if not ok then
    print 'Failed to bootstrap packer!'
    do
        return
    end
end

local function packer_startup_fun(use)
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
            require('Comment').setup {
                pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
            }
        end,
    }
    use {
        'tpope/vim-fugitive', -- git integration
        requires = {
            'tpope/vim-rhubarb', -- gihtub GBrowse
            'tommcdo/vim-fubitive', -- bitbucket GBrowse
            'shumphrey/fugitive-gitlab.vim', -- gitlab GBrowse
        },
        config = function()
            local opts = { noremap = true, silent = false }
            vim.keymap.set('n', '<leader>dd', vim.cmd.Gdiffsplit, opts)
        end,
    }
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
        'nvim-telescope/telescope.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
            'kyazdani42/nvim-web-devicons',
            -- todo: handle situation when sqlite is not installed
            'nvim-telescope/telescope-smart-history.nvim',
            'kkharji/sqlite.lua',
        },
        config = function()
            local telescope = require 'telescope'
            local actions = require 'telescope.actions'
            local builtin = require 'telescope.builtin'

            local function custom_send_to_qflist(prompt_bufnr)
                actions.send_to_qflist(prompt_bufnr)
                vim.cmd.copen { mods = { split = 'botright' } }
            end

            telescope.setup {
                defaults = {
                    mappings = {
                        i = {
                            ['<c-q>'] = custom_send_to_qflist,
                            ['<c-p>'] = actions.cycle_history_prev,
                            ['<c-n>'] = actions.cycle_history_next,
                            ['<c-k>'] = actions.move_selection_previous,
                            ['<c-j>'] = actions.move_selection_next,
                        },
                        n = {
                            ['q'] = actions.close,
                            ['<c-c>'] = actions.close,
                            ['<c-q>'] = custom_send_to_qflist,
                            ['<c-p>'] = actions.cycle_history_prev,
                            ['<c-n>'] = actions.cycle_history_next,
                            ['<c-k>'] = actions.move_selection_previous,
                            ['<c-j>'] = actions.move_selection_next,
                        },
                    },
                    layout_config = {
                        horizontal = {
                            preview_width = 0.5,
                            width = 0.9,
                        },
                    },
                    cache_picker = {
                        num_pickers = 10,
                    },
                    history = {
                        path = vim.fn.stdpath 'data' .. '/telescope_history.sqlite3'
                    }
                },
            }
            telescope.load_extension 'smart_history'

            local open_files = function()
                vim.fn.system 'git rev-parse --is-inside-work-tree'
                if vim.v.shell_error == 0 then
                    builtin.git_files {}
                else
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
                -- currently in tmux <c-m> conflicts with Enter and <c-i> with TAB so should not bind anything to those
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

            vim.keymap.set(
                'c',
                '<c-s-r>',
                -- note: this is terrible hack
                -- todo: find better way to get content of cmd prompt
                '<c-f>0"pyg_<cmd>q<cr>:Telescope command_history default_text=<c-r>p<cr>',
                vim.tbl_extend('force', opts, { silent = true })
            )
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
    use { 'stevearc/dressing.nvim',
        config = function()
            require('dressing').setup {
                input = {
                    insert_only = false,
                    winblend = 0,
                }
            }
        end
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
        cmd = { 'MirrorConfig' },
        config = function()
            local opts = { noremap = true, silent = false }
            vim.keymap.set('n', '<leader>R', '<cmd>w<cr><cmd>MirrorPush<cr>', opts)
            vim.keymap.set('n', '<leader>dr', vim.cmd.MirrorDiff, opts)
            vim.keymap.set('n', '<leader>L', vim.cmd.MirrorReload, opts)
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
            vim.keymap.set({ 'n', 'v' }, '<c-w>z', vim.cmd.ZoomWinTabToggle, opts)
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
                    for m, fun in pairs {
                        ['<a-g>'] = gs.preview_hunk,
                        ['<leader>hp'] = gs.preview_hunk,
                        ['<leader>hu'] = gs.undo_stage_hunk,
                    } do
                        vim.keymap.set('n', m, fun, opts)
                    end

                    for m, cmd in pairs {
                        ['<leader>hs'] = function()
                            vim.cmd.Gitsigns 'stage_hunk'
                        end,
                        ['<leader>hr'] = function()
                            vim.cmd.Gitsigns 'reset_hunk'
                        end,
                    } do
                        vim.keymap.set({ 'n', 'v' }, m, cmd, opts)
                    end

                    for m, cmd in pairs {
                        [']c'] = function()
                            if vim.wo.diff then
                                return ']c'
                            end
                            vim.schedule(gs.next_hunk)
                            return '<Ignore>'
                        end,
                        ['[c'] = function()
                            if vim.wo.diff then
                                return '[c'
                            end
                            vim.schedule(gs.prev_hunk)
                            return '<Ignore>'
                        end,
                    } do
                        vim.keymap.set('n', m, cmd, vim.tbl_extend('force', opts, { expr = true }))
                    end
                end,
            }
        end,
    }
    use {
        'nvim-tree/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons',
        after = 'monokai.nvim',
        keys = '<a-1>',
        cmd = { 'NvimTreeOpen', 'NvimTreeFindFile' },
        config = function()
            local nvt = require 'nvim-tree'
            nvt.setup {
                hijack_netrw = false,
                hijack_cursor = true,
                sync_root_with_cwd = true,
                reload_on_bufenter = true,
                update_focused_file = {
                    enable = true,
                    update_root = true,
                },
                actions = {
                    change_dir = {
                        enable = false,
                    },
                },
                view = {
                    float = {
                        enable = true,
                        open_win_config = function()
                            local height = vim.o.lines - 4
                            local width = math.min(80, math.floor(vim.o.columns / 3))
                            return {
                                relative = 'editor',
                                border = 'rounded',
                                row = 0,
                                col = 0,
                                height = height,
                                width = width,
                            }
                        end,
                    },
                    hide_root_folder = true,
                },
                renderer = {
                    indent_markers = {
                        enable = true,
                    },
                    highlight_opened_files = 'name',
                },
            }
            vim.keymap.set('n', '<a-1>', nvt.toggle, { noremap = true, silent = false })
            vim.api.nvim_create_autocmd('BufWinEnter', {
                pattern = 'NvimTree_*',
                callback = function()
                    vim.wo.cursorline = true
                end,
            })
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
            vim.keymap.set('n', '<leader>so', function()
                vim.cmd.SessionOpen 'default'
            end, opts)
            vim.keymap.set('n', '<leader>S', vim.cmd.SessionOpen, opts)
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
                map_c_w = true,
                map_cr = false,
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
        ft = { 'html', 'xml' },
        config = function()
            require('nvim-ts-autotag').setup()
        end,
    }
    use {
        'RRethy/vim-illuminate',
        config = function()
            require('illuminate').configure {
                delay = 500,
                filetypes_denylist = { 'LuaTree', 'nerdtree' },
            }
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
            vim.keymap.set('n', '<a-2>', vim.cmd.TagbarToggle, opts)
        end,
    }
    use {
        'jose-elias-alvarez/null-ls.nvim',
        requires = 'nvim-lua/plenary.nvim',
        config = function()
            local nls = require 'null-ls'
            local b = nls.builtins
            local u = require 'utils'
            local sources = {
                b.formatting.stylua,
                b.formatting.prettierd,
                b.formatting.tidy.with {
                    filetypes = { 'xml' },
                    extra_args = function(_)
                        return {
                            '-xml',
                            '--ident-spaces ' .. vim.fn.shiftwidth(),
                            '--wrap ' .. vim.o.textwidth,
                            '--vertical-space yes',
                        }
                    end,
                },
                b.formatting.yapf,
                b.formatting.isort,
            }
            nls.setup { sources = sources, on_attach = u.on_attach_defaults }
        end,
    }
    use { 'Vimjas/vim-python-pep8-indent', ft = { 'python' } }
    use {
        'hkupty/iron.nvim',
        -- TODO: fix/rewrite this plugin, author can not handle visual send after 2 rewrites ..
        config = function()
            local iron = require 'iron.core'
            iron.setup {
                config = {
                    repl_definition = {
                        python = {
                            command = { 'ipython' },
                        },
                    },
                    repl_open_cmd = 'vsplit',
                },
                keymaps = {
                    visual_send = '<F5>',
                    send_line = '<F5>',
                },
            }
        end,
    }
    use {
        'euclio/vim-markdown-composer',
        ft = 'markdown',
        -- building is slow, uncomment this when it is really needed
        -- run = 'cargo build --release --locked'
        setup = function()
            vim.g.markdown_composer_autostart = 0
        end,
    }
    use { 'momota/junos.vim', ft = 'junos' }
    use {
        requires = 'rafamadriz/friendly-snippets',
        'L3MON4D3/LuaSnip',
        config = function()
            local ls = require 'luasnip'
            ls.setup {
                history = true,
            }
            ls.snippets = {} -- custom snippets (some day maybe)
            require('luasnip.loaders.from_vscode').lazy_load()

            vim.keymap.set({ 'i', 's' }, '<c-j>', function()
                if ls.expand_or_locally_jumpable() then
                    return ls.expand_or_jump()
                end
            end)
            vim.keymap.set({ 'i', 's' }, '<c-k>', function()
                if ls.locally_jumpable(-1) then
                    return ls.jump(-1)
                end
            end)
            vim.keymap.set('i', '<c-l>', function()
                if ls.choice_active() then
                    ls.change_choice(1)
                end
            end)

            -- my version of smart tab
            local function feedkeys(keys)
                local ekeys = vim.api.nvim_replace_termcodes(keys, true, true, true)
                vim.api.nvim_feedkeys(ekeys, 'n', false)
            end

            vim.keymap.set({ 'i', 's' }, '<TAB>', function()
                if vim.fn.pumvisible() ~= 0 then
                    feedkeys '<c-n>'
                elseif ls.expand_or_locally_jumpable() then
                    ls.expand_or_jump()
                else
                    feedkeys '<TAB>'
                end
            end)
            vim.keymap.set({ 'i', 's' }, '<S-TAB>', function()
                if vim.fn.pumvisible() ~= 0 then
                    feedkeys '<c-p>'
                elseif ls.locally_jumpable(-1) then
                    ls.jump(-1)
                else
                    feedkeys '<c-d>'
                end
            end)
        end,
    }
    use {
        'neovim/nvim-lspconfig',
        requires = 'RRethy/vim-illuminate',
        after = 'cmp-nvim-lsp',
        config = function()
            local lsp = require 'lspconfig'
            local u = require 'utils'
            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            lsp.clangd.setup {
                cmd = { 'clangd', '--background-index' },
                on_attach = function(client, bufnr)
                    u.on_attach_defaults(client, bufnr)
                    require('illuminate').on_attach(client)
                    vim.cmd [[cnoreabbrev A ClangdSwitchSourceHeader]]
                end,
                capabilities = capabilities,
            }

            lsp.jedi_language_server.setup {
                on_attach = function(client, bufnr)
                    client.server_capabilities.documentSymbolProvider = false
                    client.server_capabilities.renameProvider = false
                    u.on_attach_defaults(client, bufnr)
                end,
                capabilities = capabilities,
            }
            lsp.pyright.setup {
                on_attach = function(client, bufnr)
                    client.server_capabilities.hoverProvider = false
                    client.server_capabilities.signatureHelpProvider = false
                    client.server_capabilities.completionProvider = false
                    u.on_attach_defaults(client, bufnr)
                end,
                settings = {
                    python = {
                        analysis = {
                            useLibraryCodeForTypes = false,
                        },
                    },
                },
                capabilities = capabilities,
            }
            for _, server in ipairs { 'rls', 'gopls', 'tsserver' } do
                lsp[server].setup {
                    on_attach = function(client, bufnr)
                        u.on_attach_defaults(client, bufnr)
                        require('illuminate').on_attach(client)
                    end,
                    capabilities = capabilities,
                }
            end

            lsp.texlab.setup {
                on_attach = u.on_attach_defaults,
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
                    capabilities = capabilities,
                },
            }

            -- only ised for for diagnostics (checking grammar using languagetool)
            lsp.ltex.setup {
                settings = {
                    ltex = {
                        diagnosticSeverity = 'hint',
                        dictionary = {
                            -- NOTE: loading dict from file does not work
                            -- TODO: check why and fix
                            ['en-US'] = { ':' .. vim.fn.stdpath 'config' .. '/spell/en.utf-8.add' },
                        },
                        disabledRules = { ['en-US'] = { 'MORFOLOGIK_RULE_EN_US' } }, -- untill I fix dictionary
                    },
                },
            }

            lsp.sumneko_lua.setup {
                settings = {
                    Lua = {
                        runtime = {
                            version = 'LuaJIT',
                        },
                        diagnostics = {
                            -- Get the language server to recognize the `vim` global
                            globals = { 'vim' },
                        },
                        workspace = {
                            checkThirdParty = false,
                            -- Make the server aware of Neovim runtime files
                            library = vim.api.nvim_get_runtime_file('', true),
                        },
                        telemetry = {
                            enable = false,
                        },
                    },
                },
                on_attach = u.on_attach_defaults,
                capabilities = capabilities,
            }
        end,
    }
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-nvim-lsp',
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-buffer',
            'onsails/lspkind.nvim',
        },
        config = function()
            local cmp = require 'cmp'
            local lspkind = require 'lspkind'

            cmp.setup {
                completion = {
                    autocomplete = false,
                },
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
                },
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                }, {
                    { name = 'buffer', keyword_length = 3 },
                }),
                mapping = {
                    ['<c-n>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.mapping.select_next_item()(fallback)
                        else
                            cmp.mapping.complete()(fallback)
                        end
                    end),
                    ['<c-j>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.mapping.select_next_item()(fallback)
                        else
                            cmp.mapping.complete()(fallback)
                        end
                    end),
                    ['<c-p>'] = cmp.mapping.select_prev_item(),
                    ['<c-k>'] = cmp.mapping.select_prev_item(),
                    ['<cr>'] = cmp.mapping.confirm(),
                    ['<c-e>'] = cmp.mapping.close(),
                    ['<c-u>'] = cmp.mapping.scroll_docs(-4),
                    ['<c-d>'] = cmp.mapping.scroll_docs(4),
                    ['('] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.close()
                        end
                        fallback()
                    end),
                },
                window = {
                    completion = {
                        col_offset = -3,
                        side_padding = 0,
                    },
                },
                formatting = {
                    fields = { 'kind', 'abbr', 'menu' },
                    format = function(entry, vim_item)
                        local kind = lspkind.cmp_format {
                            mode = 'symbol_text',
                            maxwidth = 50,
                            ellipsis_char = '...',
                        } (entry, vim_item)
                        local strings = vim.split(kind.kind, '%s', { trimempty = true })
                        kind.kind = ' ' .. strings[1] .. ' '
                        kind.menu = '    (' .. strings[2] .. ')'
                        return kind
                    end,
                },
            }
        end,
    }
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            if vim.fn.exists 'TSUpdate' ~= 0 then
                vim.cmd.TSUpdate()
            end
        end,
        config = function()
            require('nvim-treesitter.configs').setup {
                ensure_installed = {
                    'bash',
                    'bibtex',
                    'c',
                    'cmake',
                    'comment',
                    'cpp',
                    'css',
                    'diff',
                    'dockerfile',
                    'go',
                    'html',
                    'http',
                    'java',
                    'javascript',
                    'json',
                    'latex',
                    'lua',
                    'make',
                    'php',
                    'python',
                    'rst',
                    'rust',
                    'sql',
                    'toml',
                    'vim',
                    'yaml',
                },
                highlight = {
                    enable = true,
                },
                -- todo: try to make ctrl-k like in sublime text :D
                -- incremental_selection = {
                --     enable = true,
                --     init_selection = "gnn",
                -- },
                -- still not working for python :(
                -- indent = {
                --     enable = true,
                -- },
            }
            vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
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
        after = 'nvim-treesitter',
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
        'nvim-lualine/lualine.nvim',
        requires = 'kyazdani42/nvim-web-devicons',
        after = 'monokai.nvim',
        config = function()
            require('lualine').setup {
                options = {
                    theme = 'wombat',
                    globalstatus = true,
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
                extensions = { 'nvim-tree', 'fugitive', 'quickfix', 'man' },
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
        'doubleloop/monokai.nvim',
        branch = 'new_api',
        setup = function()
            vim.o.termguicolors = true
        end,
        config = function()
            local monokai = require 'monokai'
            local palette = monokai.classic
            monokai.setup {
                custom_hlgroups = {
                    SpellBad = {
                        undercurl = true,
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

            -- used by document_highlight (in case illuminate is disabled)
            vim.api.nvim_set_hl(0, 'LspReferenceText', { link = 'CursorLine' })
            vim.api.nvim_set_hl(0, 'LspReferenceWrite', { link = 'CursorLine' })
            vim.api.nvim_set_hl(0, 'LspReferenceRead', { link = 'CursorLine' })

            -- illuminate
            vim.api.nvim_set_hl(0, 'IlluminatedWordText', { link = 'CursorLine' })
            vim.api.nvim_set_hl(0, 'IlluminatedWordRead', { link = 'CursorLine' })
            vim.api.nvim_set_hl(0, 'IlluminatedWordWrite', { link = 'CursorLine' })

            -- I do not like this overwrites so switch back to defaults
            vim.api.nvim_set_hl(0, 'TelescopeNormal', { link = 'Normal' })
            vim.api.nvim_set_hl(0, 'TelescopeSelection', { link = 'Visual' })
            vim.api.nvim_set_hl(0, 'TelescopeSelectionCaret', { link = 'TelescopeSelection' })
            vim.api.nvim_set_hl(0, 'TelescopeMatching', { link = 'Special' })
            vim.api.nvim_set_hl(0, 'TelescopeMultiSelection', { link = 'Type' })
        end,
    }
end

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
