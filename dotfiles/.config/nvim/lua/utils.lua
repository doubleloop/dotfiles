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

return utils
