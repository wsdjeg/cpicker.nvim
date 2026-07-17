-- test/logger.lua
-- Mock logger module for headless testing

local M = {}

function M.derive(name)
  local logger = {}
  function logger.info(msg) end
  function logger.warn(msg) end
  function logger.error(msg) end
  function logger.debug(msg) end
  return logger
end

return M

