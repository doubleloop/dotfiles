require('colorizer').setup()
require('iron').core.set_config {
    preferred = {
        python = "ipython"
    },
    repl_open_cmd = "vsplit"
}

local completion = require 'completion'
local diagnostic = require 'diagnostic'
local lsp = require 'nvim_lsp'

local function on_attach_vim()
  completion.on_attach()
  diagnostic.on_attach()
end

lsp.pyls.setup{on_attach=on_attach_vim}
lsp.rls.setup{on_attach=on_attach_vim}
-- lsp.rust_analyzer.setup{on_attach=on_attach_vim}
lsp.sumneko_lua.setup{on_attach=on_attach_vim}
lsp.bashls.setup{on_attach=on_attach_vim}
lsp.texlab.setup{on_attach=on_attach_vim}
lsp.clangd.setup{on_attach=on_attach_vim}
-- lsp.gopls.setup{on_attach=on_attach_vim}

require('nvim-treesitter.configs').setup {
    highlight = {
        enable = true
    },
    incremental_selection = {
        enable = true,
        keymaps = {                       -- mappings for incremental selection (visual mappings)
          init_selection = 'gnn',         -- maps in normal mode to init the node/scope selection
          node_incremental = "grn",       -- increment to the upper named parent
          scope_incremental = "grc",      -- increment to the upper scope (as defined in locals.scm)
          scope_decremental = "grm",      -- decrement to the previous scope
        }
    },
    ensure_installed = 'all' -- one of 'all', 'language', or a list of languages
}
