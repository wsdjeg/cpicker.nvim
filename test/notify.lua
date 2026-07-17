-- test/notify.lua
-- Mock notify module for headless testing

local M = {}

function M.notify(msg, level)
  -- silently ignore notifications in test mode
  return { message = msg, level = level }
end

return M

