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
    paths = table.concat(paths, ',')
    return paths
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

return utils
