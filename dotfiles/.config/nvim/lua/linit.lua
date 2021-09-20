require('colorizer').setup()
require('iron').core.set_config {
    preferred = {
        python = "ipython"
    },
    repl_open_cmd = "vsplit"
}
require('lspfuzzy').setup {}

require('lualine').setup {
    options = {
        theme = 'wombat',
        icons_enabled = true,
        section_separators = '',
        component_separators = {'|', '|'}
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { },
        lualine_c = { {'filename', file_status = true, path = 1} },
        lualine_x = { 'fileformat', 'encoding', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
    },
    inactive_sections = {
        lualine_a = {  },
        lualine_b = {  },
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {  },
        lualine_z = {  }
    },
    extensions = { 'fzf', 'nvim-tree', 'fugitive' }
}

require('auto-session').setup {
    auto_save_enabled = true,
    auto_restore_enabled = false,
}

require("which-key").setup {
    plugins = {
        spelling = {
            enabled = true
        }
    }
}
require('nvim_comment').setup {}

local npairs = require('nvim-autopairs')
local Rule = require('nvim-autopairs.rule')

npairs.setup {}
npairs.add_rules({
    Rule("f'", "'", "python"),
    Rule('f"', "'", "python"),
    Rule("r'", "'", "python"),
    Rule('r"', "'", "python"),
})

-- skip it, if you use another global object
_G.MUtils = {}

MUtils.completion_confirm=function()
  if vim.fn.pumvisible() ~= 0  then
      return npairs.esc("<cr>")
  else
    return npairs.autopairs_cr()
  end
end
vim.api.nvim_set_keymap('i' , '<CR>','v:lua.MUtils.completion_confirm()', {expr = true , noremap = true})

require('nvim-ts-autotag').setup {}

require('gitsigns').setup {
    keymaps = {
        noremap = true,
        ['n ]c'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'"},
        ['n [c'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'"},
        ['n <a-g>'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
    }
}

require('formatter').setup {
    logging = false,
    filetype = {
        python = {
            function()
                return {
                    exe = 'yapf',
                    args = {},
                    stdin = true
                }
            end,
            function()
                return {
                    exe = 'isort',
                    args = {'-q', '-'},
                    stdin = true
                }
            end,
        },
        lua = {
            function()
                return {
                    exe = "stylua",
                    args = {
                        "--config-path " .. vim.fn.getenv 'HOME' .. "/.config/stylua/stylua.toml",
                        "-",
                    },
                    stdin = true,
                }
            end,
        },
    }
}

require('autosave').setup {
    enabled = true,
    execution_message = "",
    events = {"InsertLeave", "TextChanged", "FocusLost", "BufHidden", "ExitPre"},
    conditions = {
        exists = true,
        filetype_is_not = {},
        modifiable = true
    },
    write_all_buffers = false,
    on_off_commands = true,
    clean_command_line_interval = 0,
    debounce_delay = 1000
}

local lsp = require 'lspconfig'

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false,
        signs = true,
        update_in_insert = false,
        underline = false,
    }
)

local function on_attach_fun(client)
    require 'illuminate'.on_attach(client)
end

lsp.clangd.setup{
    cmd = { "clangd-11", "--background-index" };
    on_attach = on_attach_fun;
}

lsp.jedi_language_server.setup{}
lsp.pyright.setup{
    settings = {
        python = {
            analysis = {
                useLibraryCodeForTypes = false;
            }
        }
    }
}
lsp.rls.setup{on_attach=on_attach_fun}
lsp.gopls.setup{on_attach=on_attach_fun}

lsp.texlab.setup{
    settings = {
        latex = {
            build = {
                args = {"-pdf", "-interaction=nonstopmode", "-synctex=1"};
                executable = "latexmk";
                -- forwardSearchAfter = true,
                onSave = true;
            },
            forwardSearch = {
                executable = 'zathura';
                args = {"--synctex-forward", "%l:1:%f", "%p"};
                -- onSave = true;
            },
        },
    },
}

local sumneko_root_path = vim.fn.getenv 'HOME' .. '/src/lua-language-server'
local sumneko_binary = sumneko_root_path .. "/bin/Linux/lua-language-server"

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

lsp.sumneko_lua.setup {
    cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
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
                globals = {'vim'},
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
    on_attach = on_attach_fun,
}

require('nvim-treesitter.configs').setup {
    highlight = {
        enable = true,
    },
    textobjects = {
        select = {
            enable = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["ac"] = "@class.outer",
            },
        },
        move = {
            enable = true,
            goto_next_start = {
                ["]]"] = "@function.outer",
                ["]c"] = "@class.outer",
            },
            goto_next_end = {
                ["]["] = "@function.outer",
                ["]C"] = "@class.outer",
            },
            goto_previous_start = {
                ["[["] = "@function.outer",
                ["[c"] = "@class.outer",
            },
            goto_previous_end = {
                ["[]"] = "@function.outer",
                ["[C"] = "@class.outer",
            },
        },
        -- todo: more elements could be swapped
        swap = {
            enable = true,
            swap_next = {
                ["g>"] = "@parameter.inner",
            },
            swap_previous = {
                ["g<"] = "@parameter.inner",
            },
        },
    },
}
