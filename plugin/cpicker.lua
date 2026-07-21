--=============================================================================
-- cpicker.lua
-- Copyright (c) 2019-2024 Wang Shidong & Contributors
-- Author: Wang Shidong < wsdjeg@outlook.com >
-- URL: https://spacevim.org
-- License: GPLv3
--=============================================================================

-- detached cpicker need this var
if not vim.g.spacevim_data_dir then
    vim.g.spacevim_data_dir = '~/.cache/'
end

if vim.api.nvim_create_user_command then
    local formats = { 'rgb', 'hsl', 'hsv', 'cmyk', 'hwb', 'linear', 'lab' }
    local subcommands = { 'cursor', 'mix', 'hl', 'clear' }

    local function complete(opt)
        local args = opt.fargs
        if #args <= 1 then
            if #args == 1 then
                local sub = args[1]
                if sub == 'mix' or sub == 'clear' then
                    return {}
                elseif sub == 'cursor' or sub == 'hl' then
                    local result = {}
                    for _, f in ipairs(formats) do
                        table.insert(result, f)
                    end
                    return result
                end
            end
            local result = {}
            for _, s in ipairs(subcommands) do
                table.insert(result, s)
            end
            for _, f in ipairs(formats) do
                table.insert(result, f)
            end
            return result
        end
        if args[1] == 'cursor' or args[1] == 'hl' then
            local result = {}
            for _, f in ipairs(formats) do
                table.insert(result, f)
            end
            return result
        end
        return {}
    end

    vim.api.nvim_create_user_command('Cpicker', function(opt)
        local fargs = opt.fargs
        if #fargs == 0 then
            require('cpicker').picker(fargs)
            return
        end

        local sub = fargs[1]

        if sub == 'cursor' then
            local fmts = {}
            for i = 2, #fargs do
                table.insert(fmts, fargs[i])
            end
            require('cpicker.util').set_default_color(fmts)
            require('cpicker').picker(fmts)
        elseif sub == 'mix' then
            local colors = {}
            for i = 2, #fargs do
                table.insert(colors, fargs[i])
            end
            require('cpicker.mix').color_mix(unpack(colors))
        elseif sub == 'hl' then
            local fmts = {}
            for i = 2, #fargs do
                table.insert(fmts, fargs[i])
            end
            local name, hl = require('cpicker.util').get_cursor_hl()
            require('cpicker.util').set_default_color(fmts)
            require('cpicker').change_cursor_highlight(name, hl, fmts)
        elseif sub == 'clear' then
            require('cpicker.util').clear_color_patch()
        else
            require('cpicker').picker(fargs)
        end
    end, { nargs = '*', complete = complete })

    local group = vim.api.nvim_create_augroup('cpicker', { clear = true })
    vim.api.nvim_create_autocmd({ 'ColorScheme' }, {
        group = group,
        pattern = { '*' },
        callback = function(ev)
            require('cpicker.util').patch_color(ev.match)
        end,
    })
    require('cpicker.util').patch_color(vim.g.colors_name)
end

