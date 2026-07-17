-- test/minimal_init.lua
-- Minimal Neovim configuration for testing

print('Initializing test environment...')

-- Set up essential settings
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = false
vim.opt.verbose = 1

-- Set up package path for:
-- 1. lua/?.lua - Main plugin source code
-- 2. test/?.lua - Mock modules (notify.lua, logger.lua)
-- 3. test/.deps/?.lua - Test dependencies (luaunit)
package.path = 'lua/?.lua;test/?.lua;test/.deps/?.lua;' .. package.path
vim.opt.runtimepath:prepend('.')

-- Create temporary test data directory (for color patch storage)
local test_dir = vim.fn.tempname() .. '_cpicker_test'
vim.fn.mkdir(test_dir, 'p')
vim.g.spacevim_data_dir = test_dir .. '/'

-- Load plugin with test configuration
local ok, err = pcall(function()
  require('cpicker')
end)

if not ok then
  print('Error initializing test environment: ' .. err)
else
  print('Test environment initialized successfully')
  print('Test directory: ' .. test_dir)
end

