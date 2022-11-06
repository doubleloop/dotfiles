local utils = {}

utils.get_gcc_include_paths = function(ft)
    if ft == 'cpp' then
        ft = 'c++'
    elseif ft ~= 'c++' then
        ft = 'c'
    end
    local cmd = 'gcc -Wp,-v -x ' .. ft .. ' -fsyntax-only /dev/null 2>&1'
    local pattern = '#include <...> search starts here:\n' .. '(.*)' .. 'End of search list.'
    local out = vim.fn.system(cmd)
    local m = string.match(out, pattern)
    local paths = { '.' }
    for p in string.gmatch(m, '%S+') do
        table.insert(paths, p)
    end
    table.insert(paths, '**')
    return table.concat(paths, ',')
end

utils.pytest_file_toggle = function()
    local file = vim.fn.expand('%:t')
    local root = vim.fn.expand('%:p:h')
    local alt_file
    if file:match('^test_.+%.py$') then
        alt_file = file:sub(6)
    elseif file:match('^.+%.py$') then
        alt_file = 'test_' .. file
    else
        return
    end
    local candidate = root .. '/' .. alt_file
    if vim.fn.bufexists(candidate) ~= 0 then
        vim.cmd('b ' .. candidate)
    elseif vim.fn.filewritable('**/' .. alt_file) == 1 then
        vim.cmd('e **/' .. alt_file)
    elseif alt_file:match('^test_') then
        vim.cmd('e ' .. candidate)
    end
end

utils.on_attach_defaults = function(_, bufnr)
    if vim.b[bufnr].lsp_defaults_attached then
        return
    end
    local tb = require 'telescope.builtin'
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    vim.api.nvim_buf_set_option(bufnr, 'tagfunc', 'v:lua.vim.lsp.tagfunc')
    vim.api.nvim_buf_set_option(bufnr, 'formatexpr', 'v:lua.vim.lsp.formatexpr()')

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
            ['<leader>='] = vim.lsp.buf.format,
        }
    do
        vim.keymap.set('n', m, v, opts)
    end

    vim.keymap.set('i', '<a-s>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('v', '<leader>=', vim.lsp.buf.format, opts)
    vim.b[bufnr].lsp_defaults_attached = true
end

return utils
