--=============================================================================
-- cpicker.lua
-- Copyright (c) 2019-2024 Wang Shidong & Contributors
-- Author: Wang Shidong < wsdjeg@outlook.com >
-- URL: https://spacevim.org
-- License: GPLv3
--=============================================================================

local M = {}

local winid
local bufnr
local color_hi = '#000000'

local hi = require('spacevim.api.vim.highlight')
local notify = require('spacevim.api.notify')
local log = require('spacevim.logger').derive('cpicker')
local util = require('cpicker.util')

local enabled_formats = {}
local increase_keys = {}
local reduce_keys = {}

local function update_buf_text()
  local rst = {}
  for _, format in ipairs(enabled_formats) do
    local ok, f = pcall(require, 'cpicker.formats.' .. format)
    if ok then
      local funcs = f.increase_reduce_functions()
      for i, text in ipairs(f.buf_text()) do
        table.insert(rst, text)
        increase_keys[#rst] = funcs[i][1]
        reduce_keys[#rst] = funcs[i][2]
      end
    end
  end
  table.insert(rst, '')
  for _, format in ipairs(enabled_formats) do
    local ok, f = pcall(require, 'cpicker.formats.' .. format)
    if ok then
      table.insert(rst, f.color_code())
    end
  end
  local normal_bg = hi.group2dict('Normal').guibg
  hi.hi({
    name = 'SpaceVimPickerCode',
    guifg = color_hi,
    guibg = normal_bg,
  })
  hi.hi({
    name = 'SpaceVimPickerNoText',
    guifg = normal_bg,
    guibg = normal_bg,
  })
  hi.hi({
    name = 'SpaceVimPickerBackground',
    guibg = color_hi,
    guifg = color_hi,
  })

  vim.api.nvim_set_option_value('modifiable', true, {
    buf = bufnr,
  })
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, rst)
  vim.api.nvim_set_option_value('modifiable', false, {
    buf = bufnr,
  })
  vim.api.nvim_win_set_config(winid, {
    height = #rst + 1
  })
end

-- https://zenn.dev/kawarimidoll/articles/a8ac50a17477bd

local function copy_color()
  local from, to = vim
    .regex([[#[0123456789ABCDEF]\+\|rgb(\d\+,\s\d\+,\s\d\+)\|hsl(\d\+,\s\d\+%,\s\d\+%)\|hsv(\d\+,\s\d\+%,\s\d\+%)\|cmyk(\d\+%,\s\d\+%,\s\d\+%,\s\d\+%)]])
    :match_str(vim.fn.getline('.'))
  if from then
    vim.fn.setreg('+', string.sub(vim.fn.getline('.'), from, to + 1))
    notify.notify('copyed:' .. string.sub(vim.fn.getline('.'), from, to + 1))
  end
end

local function increase()
  if increase_keys[vim.fn.line('.')] then
    local t, code = increase_keys[vim.fn.line('.')]()
    color_hi = util.get_hex_code(t, code)
    for _, format in ipairs(enabled_formats) do
      local ok, f = pcall(require, 'cpicker.formats.' .. format)
      if ok then
        f.on_change(t, code)
      end
    end
  end
  update_buf_text()
end

local function reduce()
  if reduce_keys[vim.fn.line('.')] then
    local t, code = reduce_keys[vim.fn.line('.')]()
    color_hi = util.get_hex_code(t, code)
    for _, format in ipairs(enabled_formats) do
      local ok, f = pcall(require, 'cpicker.formats.' .. format)
      if ok then
        f.on_change(t, code)
      end
    end
  end
  update_buf_text()
end

M.picker = function(formats)
  enabled_formats = formats
  log.info(vim.inspect(enabled_formats))
  if not bufnr or not vim.api.nvim_win_is_valid(bufnr) then
    bufnr = vim.api.nvim_create_buf(false, false)
    vim.api.nvim_set_option_value('buftype', 'nofile', {
      buf = bufnr,
    })
    vim.api.nvim_set_option_value('filetype', 'spacevim_cpicker', {
      buf = bufnr,
    })
    vim.api.nvim_set_option_value('bufhidden', 'wipe', {
      buf = bufnr,
    })
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'l', '', {
      callback = increase,
    })
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'h', '', {
      callback = reduce,
    })
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Right>', '', {
      callback = increase,
    })
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Left>', '', {
      callback = reduce,
    })
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'q', '', {
      callback = function()
        vim.api.nvim_win_close(winid, true)
      end,
    })
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Cr>', '', {
      callback = copy_color,
    })
  end
  if not winid or not vim.api.nvim_win_is_valid(winid) then
    winid = vim.api.nvim_open_win(bufnr, true, {
      relative = 'cursor',
      border = 'single',
      width = 40,
      height = 10,
      row = 1,
      col = 1,
    })
  end
  vim.api.nvim_set_option_value('number', false, {
    win = winid,
  })
  vim.api.nvim_set_option_value('winhighlight', 'NormalFloat:Normal,FloatBorder:WinSeparator', {
    win = winid,
  })
  vim.api.nvim_set_option_value('modifiable', false, {
    buf = bufnr,
  })
  update_buf_text()
end

return M