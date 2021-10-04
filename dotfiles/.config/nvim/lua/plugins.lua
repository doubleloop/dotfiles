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

local use = require('packer').use

local function packer_startup_fun()
    use 'wbthomason/packer.nvim'

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
        'terrortylor/nvim-comment',
        config = function()
            require('nvim_comment').setup {}
        end,
    }
    use 'tpope/vim-fugitive' -- git integration
    use { 'tpope/vim-rhubarb', after = 'vim-fugitive' } -- gihtub Gbrowse
    use { 'tommcdo/vim-fubitive', after = 'vim-fugitive' } -- bitbucket Gbrowse
    use {
        'tpope/vim-sleuth', -- guess ts heuristically
        cmd = { 'Sleuth' },
        setup = function()
            vim.g.sleuth_automatic = 0
        end,
    }
    use { 'ericpruitt/tmux.vim', ft = 'tmux' }
    use {
        'numToStr/Navigator.nvim',
        config = function()
            require('Navigator').setup {
                disable_on_zoom = true,
            }
            local maps = {
                ['<a-h>'] = 'left',
                ['<a-j>'] = 'down',
                ['<a-k>'] = 'up',
                ['<a-l>'] = 'right',
                ['<a-\\'] = 'previous',
            }
            local opts = { noremap = true, silent = true }
            for m, cmd in pairs(maps) do
                cmd = '<cmd>' .. "lua require('Navigator')." .. cmd .. '()<cr>'
                vim.api.nvim_set_keymap('n', m, cmd, opts)
                vim.api.nvim_set_keymap('i', m, '<esc>' .. cmd, opts)
                vim.api.nvim_set_keymap('v', m, '<esc>' .. cmd, opts)
                vim.api.nvim_set_keymap('c', m, '<c-c>' .. cmd, opts)
                vim.api.nvim_set_keymap('t', m, '<c-\\><c-n>' .. cmd, opts)
            end
        end,
    }
    use {
        'Pocco81/AutoSave.nvim',
        config = function()
            require('autosave').setup {
                enabled = true,
                execution_message = '',
                events = { 'InsertLeave', 'TextChanged', 'FocusLost', 'BufHidden', 'ExitPre' },
                conditions = {
                    exists = true,
                    filetype_is_not = {},
                    modifiable = true,
                },
                write_all_buffers = false,
                on_off_commands = true,
                clean_command_line_interval = 0,
                debounce_delay = 1000,
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
            require('telescope').setup {
                defaults = {
                    mappings = {
                        i = {
                            ['<esc>'] = actions.close,
                        },
                        n = {
                            ['q'] = actions.close,
                        },
                    },
                },
            }
            local opts = { noremap = true, silent = false }
            vim.api.nvim_set_keymap('n', '<leader>F', '<cmd>Telescope find_files<cr>', opts)
            vim.api.nvim_set_keymap('n', '<leader>h', '<cmd>Telescope help_tags<cr>', opts)
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
        'folke/which-key.nvim',
        config = function()
            require('which-key').setup {
                plugins = {
                    spelling = {
                        enabled = true,
                    },
                },
            }
        end,
    }
    use 'tversteeg/registers.nvim'
    use {
        'junegunn/fzf.vim',
        requires = {
            'junegunn/fzf',
            run = function()
                vim.fn['fzf#install']()
            end,
        },
        setup = function()
            vim.g.fzf_command_prefix = 'Fzf'
            vim.g.fzf_layout = { window = { width = 0.9, height = 0.8 } }
        end,
        config = function()
            local prefix = vim.g.fzf_command_prefix
            local maps = {
                ['<leader>p'] = 'Files',
                ['<leader>:'] = 'Commands',
                ['<leader>b'] = 'Buffer',
                ['<leader>m'] = 'History',
                ['<leader><c-r>'] = 'History:',
                ['<leader>l'] = 'BLines',
                ['<a-e>'] = 'BTags',
            }
            if vim.fn.executable 'rg' then
                maps['<leader>/'] = 'Rg'
            elseif vim.fn.executalbe 'ag' then
                maps['<leader>/'] = 'Ag'
            end
            local opts = { noremap = true, silent = false }
            for m, cmd in pairs(maps) do
                vim.api.nvim_set_keymap('n', m, '<cmd>' .. prefix .. cmd .. '<cr>', opts)
            end
        end,
    }
    use {
        'ojroques/nvim-lspfuzzy',
        after = { 'fzf.vim', 'nvim-lspconfig' },
        config = function()
            require('lspfuzzy').setup {}
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
        'vigoux/LanguageTool.nvim',
        setup = function()
            vim.g.languagetool_server_jar =
                '$HOME/.local/share/languagetool/languagetool-server.jar'
        end,
    }
    use {
        -- todo: check out chipsenkbeil/distant.nvim
        'zenbro/mirror.vim',
        config = function()
            local opts = { noremap = true, silent = false }
            vim.api.nvim_set_keymap('n', '<leader>rr', '<cmd>w<cr><cmd>MirrorPush<cr>', opts)
            vim.api.nvim_set_keymap('n', '<leader>rd', '<cmd>MirrorDiff<cr>', opts)
            vim.api.nvim_set_keymap('n', '<leader>rl', '<cmd>MirrorReload<cr>', opts)
        end,
    }
    use {
        'troydm/zoomwintab.vim',
        keys = '<c-w>z',
        setup = function()
            vim.g.zoomwintab_remap = 0
            local opts = { noremap = true, silent = true }
            vim.api.nvim_set_keymap('n', '<c-w>z', '<cmd>ZoomWinTabToggle<cr>', opts)
            vim.api.nvim_set_keymap('v', '<c-w>z', '<c-\\><c-n><cmd>ZoomWinTabToggle<cr>gv', opts)
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
            require('gitsigns').setup {
                keymaps = {
                    noremap = true,
                    ['n ]c'] = {
                        expr = true,
                        "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'",
                    },
                    ['n [c'] = {
                        expr = true,
                        "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'",
                    },
                    ['n <a-g>'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
                },
            }
        end,
    }
    use {
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons',
        keys = '<a-1>',
        setup = function()
            vim.g.nvim_tree_indent_markers = 1
        end,
        config = function()
            require('nvim-tree').setup {
                hijack_cursor = true,
                update_focused_file = { enable = true },
                update_cwd = true,
            }
            local opts = { noremap = true, silent = false }
            vim.api.nvim_set_keymap('n', '<a-1>', '<cmd>NvimTreeToggle<cr>', opts)
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
            local opts = { noremap = true, silent = false }
            vim.api.nvim_set_keymap('n', '<leader>so', '<cmd>SessionOpen default<cr>', opts)
            vim.api.nvim_set_keymap('n', '<leader>S', '<cmd>SessionOpen<cr>', opts)
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

            -- skip it, if you use another global object
            _G.MUtils = {}

            MUtils.completion_confirm = function()
                if vim.fn.pumvisible() ~= 0 then
                    return npairs.esc '<cr>'
                else
                    return npairs.autopairs_cr()
                end
            end
            vim.api.nvim_set_keymap(
                'i',
                '<cr>',
                'v:lua.MUtils.completion_confirm()',
                { expr = true, noremap = true }
            )
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
            local opts = { noremap = true, silent = true }
            vim.api.nvim_set_keymap(
                'n',
                '<c-n>',
                '<cmd>lua require"illuminate".next_reference{wrap=true}<cr>',
                opts
            )
            vim.api.nvim_set_keymap(
                'n',
                '<c-p>',
                '<cmd>lua require"illuminate".next_reference{reverse=true,wrap=true}<cr>',
                opts
            )
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
            vim.api.nvim_set_keymap('n', '<a-2>', '<cmd>TagbarToggle<cr>', opts)
        end

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
                                    '--config-path '
                                        .. vim.fn.getenv 'HOME'
                                        .. '/.config/stylua/stylua.toml',
                                    '-',
                                },
                                stdin = true,
                            }
                        end,
                    },
                },
            }
            vim.cmd [[ au FileType python,lua nnoremap <buffer> <leader>= <cmd>Format<cr> ]]
        end,
    }
    use { 'Vimjas/vim-python-pep8-indent', ft = { 'python' } }
    use {
        'BurningEther/iron.nvim',
        setup = function()
            vim.g.iron_map_defaults = 0
        end,
        config = function()
            require('iron').core.set_config {
                preferred = {
                    python = 'ipython',
                },
                repl_open_cmd = 'vsplit',
            }

            local opts = { noremap = false, silent = false }
            vim.api.nvim_set_keymap('n', '<F5>', '<Plug>(iron-send-line)', opts)
            vim.api.nvim_set_keymap('v', '<F5>', '<esc><Plug>(iron-visual-send)', opts)
            vim.api.nvim_set_keymap('n', '<F8>', '<Plug>(iron-interrupt)', opts)
        end,
    }
    use {
        'euclio/vim-markdown-composer',
        -- building is slow, better to call it manually when it is needed
        -- run = 'cargo build --release'
        config = function()
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
            local function map(m, k, v)
                vim.api.nvim_buf_set_keymap(0, m, k, v, opts)
            end
            map('n', '<leader>cc', '<cmd>CoqLaunch<cr>')
            map('n', '<leader>cq', '<cmd>CoqKill<cr>')
            map('n', '<leader><F5>', '<cmd>CoqToCursor<cr>')
            for m, cmd in pairs { ['c-n'] = 'CoqNext', ['c-p'] = 'CoqUndo' } do
                map('n', m, '<cmd>' .. cmd .. '<cr>')
                map('v', m, '<cmd>' .. cmd .. '<cr>')
                map('i', m, [[<c-\><c-o><cmd>]] .. cmd .. '<cr>')
            end
        end,
    }
    use {
        'neovim/nvim-lspconfig',
        requires = 'RRethy/vim-illuminate',
        config = function()
            local lsp = require 'lspconfig'
            local opts = { noremap = true, silent = true }
            local function on_attach_defaults(_, bufnr)
                vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
                vim.api.nvim_buf_set_keymap(
                    bufnr,
                    'i',
                    '<c-n>',
                    [[ pumvisible() ? '<c-n>' : '' ]],
                    { expr = true, noremap = true }
                )

                local function map(m, k, v)
                    vim.api.nvim_buf_set_keymap(bufnr, m, k, v, opts)
                end
                map('n', '<c-]>', '<cmd>lua vim.lsp.buf.definition()<cr>')
                map('n', '<c-t>', '<c-o>zt')
                map('n', 'gd', '<cmd>lua vim.lsp.buf.declaration()<cr>')
                map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')
                map('n', '<leader>n', '<cmd>lua vim.lsp.buf.references()<cr>')

                map('n', '<c-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
                map('i', '<a-s>', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
                map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')
                map('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<cr>')

                map('n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<cr>')
                map('n', '<leader>.', '<cmd>lua vim.lsp.buf.code_action()<cr>')

                map('n', '<a-d>', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>')
                map('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>')
                map('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<cr>')

                -- map('n', '<a-e>', '<cmd>lua vim.lsp.buf.document_symbol()<cr>')

                local ft = vim.api.nvim_buf_get_option(bufnr, 'filetype')
                if ft ~= 'python' and ft ~= 'lua' then
                    map('n', '<leader>=', '<cmd>lua vim.lsp.buf.formatting()<cr>')
                    map('v', '<leader>=', '<cmd>lua vim.lsp.buf.range_formatting()<cr>')
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
            for _, server in ipairs { 'rls', 'gopls' } do
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
                    latex = {
                        build = {
                            args = { '-pdf', '-interaction=nonstopmode', '-synctex=1' },
                            executable = 'latexmk',
                            -- forwardSearchAfter = true,
                            onSave = true,
                        },
                        forwardSearch = {
                            executable = 'zathura',
                            args = { '--synctex-forward', '%l:1:%f', '%p' },
                            -- onSave = true;
                        },
                    },
                },
            }

            local sumneko_root_path = vim.fn.getenv 'HOME' .. '/src/lua-language-server'
            local sumneko_binary = sumneko_root_path .. '/bin/Linux/lua-language-server'

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
                    'python',
                    'c',
                    'cpp',
                    'go',
                    'rust',
                    'lua',
                    'vim',
                    'latex',
                    'bibtex',
                    'javascript',
                    'css',
                    'html',
                    'json',
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
                -- indent = {
                --     enable = true,
                -- },
            }
        end,
    }
    use {
        'nvim-treesitter/nvim-treesitter-textobjects',
        requires = 'nvim-treesitter/nvim-treesitter',
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
        'nvim-treesitter/playground',
        requires = 'nvim-treesitter/nvim-treesitter',
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
        'hoob3rt/lualine.nvim',
        requires = 'kyazdani42/nvim-web-devicons',
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
                extensions = { 'fzf', 'nvim-tree', 'fugitive' },
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
        config = function()
            local monokai = require 'monokai'
            local palette = monokai.classic
            monokai.setup {
                custom_hlgroups = {
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
                },
            }
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
    },
}
