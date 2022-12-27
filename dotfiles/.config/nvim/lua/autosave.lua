local M = {}

local a = vim.api
local uv = vim.loop

local augroup = nil
local periodic_saver = uv.new_timer()

local default_cfg = {
    debounce_trigger_events = { 'InsertLeave', 'TextChanged', 'FocusLost', 'BufHidden' },
    trigger_events = {'ExitPre', 'VimSuspend'},
    repeat_interval = 5000,
    debounce_interval = 1000,
    autostart = true,
}

local cfg = vim.deepcopy(default_cfg)

local function valid_for_write(buf)
    if not a.nvim_buf_is_valid(buf) then
        return false
    end
    local bo = vim.bo[buf]
    if not bo.modifiable or bo.buftype ~= '' or not bo.modified then
        return false
    end
    return true
end

local function do_save()
    vim.cmd.update { mods = { silent = true, emsg_silent = true } }
end

local function save(buf)
    buf = buf or a.nvim_get_current_buf()
    if valid_for_write(buf) then
        a.nvim_buf_call(buf, do_save)
    end
end

-- debounce only when concurrent calls are on the same buffer
-- otherwise call instantly
local function debounce(fn, interval)
    local timer = uv.new_timer()
    local debounced = false
    local prevbuf = nil
    return function(buf)
        buf = buf or a.nvim_get_current_buf()
        if timer:is_active() then
            if buf == prevbuf then
                debounced = true
                return
            end
            if debounced then
                fn(prevbuf)
            end
        end
        debounced = false
        prevbuf = buf
        fn(buf)
        timer:start(interval, 0, function()
            if debounced and buf == prevbuf then
                fn(buf)
            end
        end)
    end
end

M.on = function()
    if augroup ~= nil then
        return
    end
    periodic_saver:start(cfg.repeat_interval, cfg.repeat_interval, vim.schedule_wrap(save))
    augroup = a.nvim_create_augroup('auto_save', { clear = true })
    a.nvim_create_autocmd(cfg.debounce_trigger_events, {
        group = augroup,
        pattern = '*',
        callback = function(args)
            local fn = debounce(function()
                vim.schedule_wrap(save)()
                periodic_saver:again()
            end, cfg.debounce_interval)
            fn(args.buf)
        end
    })
    a.nvim_create_autocmd(cfg.trigger_events, {
        group = augroup,
        pattern = '*',
        callback = function(args)
            return save(args.buf)
        end
    })
end

M.off = function()
    if augroup == nil then
        return
    end
    a.nvim_del_augroup_by_id(augroup)
    augroup = nil
    periodic_saver:stop()
end

M.toggle = function()
    if augroup == nil then
        M.on()
        vim.notify('autosave on')
    else
        M.off()
        vim.notify('autosave off')
    end
end

M.setup = function(usercfg)
    if type(usercfg) == 'table' then
        cfg = vim.tbl_deep_extend('force', default_cfg, usercfg)
    end
    vim.api.nvim_create_user_command('AutosaveOn', M.on, { nargs = 0 })
    vim.api.nvim_create_user_command('AutosaveOff', M.off, { nargs = 0 })
    vim.api.nvim_create_user_command('AutosaveToggle', M.toggle, { nargs = 0 })
    if cfg.autostart then
        M.on()
    end
end

return M
