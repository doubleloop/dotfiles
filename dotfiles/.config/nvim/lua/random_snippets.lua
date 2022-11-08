-- some random things I used for testing how vim works
M = {}

local a = vim.api

local function create_test_autocmds(triggers)
    local augroup = a.nvim_create_augroup('test_autocmds', { clear = true })
    for _, trigger in ipairs(triggers) do
        a.nvim_create_autocmd(trigger, {
            group = augroup,
            pattern = '*',
            callback = function()
                vim.notify('fired: ' .. trigger)
            end,
        })
    end
end

M.setup = function()
    create_test_autocmds {
        'FocusGained',
        'FocusLost',
        'BufHidden',
        'BufAdd',
        'BufEnter',
        'BufLeave',
        'BufNew',
        'BufNewFile',
        'BufWinEnter',
        'FileType',
        'TermOpen',
        'VimResized',
        'VimResized',
        'WinEnter',
        'WinNew',
    }

    -- some functions to inspect colorscheme settings
    -- when treesitter is not used
    vim.cmd [[
        function! SynStackFun()
        echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
        endfunc
        command! SyntaxStack call SynStackFun()
        command! FgColor :echo synIDattr(synIDtrans(synID(line("."), col("."), 1)), "fg")
        command! BgColor :echo synIDattr(synIDtrans(synID(line("."), col("."), 1)), "bg")
    ]]
end

return M
