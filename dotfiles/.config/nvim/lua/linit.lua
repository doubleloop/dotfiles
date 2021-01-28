require('colorizer').setup()
require('iron').core.set_config {
    preferred = {
        python = "ipython"
    },
    repl_open_cmd = "vsplit"
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

local function on_attach_fun()
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

local sumneko_root_path = vim.fn.expand('$HOME/src/lua-language-server')
lsp.sumneko_lua.setup {
    cmd = {sumneko_root_path.."/bin/Linux/lua-language-server", "-E", sumneko_root_path.."/main.lua"},
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Setup your lua path
                path = vim.split(package.path, ';'),
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {'vim'},
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = {
                    [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                    [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                },
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
