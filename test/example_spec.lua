-- test/example_spec.lua
-- Example tests for cpicker.nvim color conversion functions

local lu = require('luaunit')
local color = require('cpicker.color')
local util = require('cpicker.util')

TestColorConversion = {}

function TestColorConversion:test_rgb2hex()
  -- pure red
  local hex = color.rgb2hex(1, 0, 0)
  lu.assertEquals(hex, '#FF0000')
  -- pure green
  hex = color.rgb2hex(0, 1, 0)
  lu.assertEquals(hex, '#00FF00')
  -- pure blue
  hex = color.rgb2hex(0, 0, 1)
  lu.assertEquals(hex, '#0000FF')
  -- white
  hex = color.rgb2hex(1, 1, 1)
  lu.assertEquals(hex, '#FFFFFF')
  -- black
  hex = color.rgb2hex(0, 0, 0)
  lu.assertEquals(hex, '#000000')
end

function TestColorConversion:test_hex2rgb()
  local r, g, b = color.hex2rgb('#FF0000')
  lu.assertEquals(r, 1.0)
  lu.assertEquals(g, 0.0)
  lu.assertEquals(b, 0.0)

  r, g, b = color.hex2rgb('#00FF00')
  lu.assertEquals(r, 0.0)
  lu.assertEquals(g, 1.0)
  lu.assertEquals(b, 0.0)
end

function TestColorConversion:test_rgb2hsl()
  -- pure red should be h=0, s=1, l=0.5
  local h, s, l = color.rgb2hsl(1, 0, 0)
  lu.assertEquals(h, 0)
  lu.assertEquals(s, 1.0)
  lu.assertEquals(l, 0.5)
end

function TestColorConversion:test_hsl2rgb()
  -- h=0, s=1, l=0.5 should be pure red
  local r, g, b = color.hsl2rgb(0, 1, 0.5)
  lu.assertEquals(math.floor(r * 255 + 0.5), 255)
  lu.assertEquals(math.floor(g * 255 + 0.5), 0)
  lu.assertEquals(math.floor(b * 255 + 0.5), 0)
end

function TestColorConversion:test_rgb2hsv()
  local h, s, v = color.rgb2hsv(1, 0, 0)
  lu.assertEquals(h, 0)
  lu.assertEquals(s, 1.0)
  lu.assertEquals(v, 1.0)
end

function TestColorConversion:test_hsv2rgb()
  local r, g, b = color.hsv2rgb(0, 1, 1)
  lu.assertAlmostEquals(r, 1.0, 0.001)
  lu.assertAlmostEquals(g, 0.0, 0.001)
  lu.assertAlmostEquals(b, 0.0, 0.001)
end

function TestColorConversion:test_rgb2cmyk()
  -- white should be c=0, m=0, y=0, k=0
  local c, m, y, k = color.rgb2cmyk(1, 1, 1)
  lu.assertEquals(c, 0)
  lu.assertEquals(m, 0)
  lu.assertEquals(y, 0)
  lu.assertEquals(k, 0)
  -- black should be k=1
  c, m, y, k = color.rgb2cmyk(0, 0, 0)
  lu.assertEquals(k, 1)
end

function TestColorConversion:test_cmyk2rgb()
  local r, g, b = color.cmyk2rgb(0, 0, 0, 0)
  lu.assertAlmostEquals(r, 1.0, 0.001)
  lu.assertAlmostEquals(g, 1.0, 0.001)
  lu.assertAlmostEquals(b, 1.0, 0.001)
end

function TestColorConversion:test_roundtrip_rgb_hsl()
  -- Test round-trip: rgb -> hsl -> rgb
  local orig_r, orig_g, orig_b = 0.5, 0.3, 0.7
  local h, s, l = color.rgb2hsl(orig_r, orig_g, orig_b)
  local r, g, b = color.hsl2rgb(h, s, l)
  lu.assertAlmostEquals(r, orig_r, 0.01)
  lu.assertAlmostEquals(g, orig_g, 0.01)
  lu.assertAlmostEquals(b, orig_b, 0.01)
end

TestUtilFunctions = {}

function TestUtilFunctions:test_generate_bar()
  local bar = util.generate_bar(0.5, '+')
  lu.assertTrue(#bar > 0)
  -- 0.5 of 24 chars should be 12
  lu.assertEquals(#bar, 12)
end

function TestUtilFunctions:test_increase()
  local v = util.increase(0.5, 100, 0, 1)
  -- step = (1-0)/100 = 0.01
  -- v = (floor(0.5/0.01 + 0.5) + 1) * 0.01 = (50 + 1) * 0.01 = 0.51
  lu.assertAlmostEquals(v, 0.51, 0.001)
end

function TestUtilFunctions:test_reduce()
  local v = util.reduce(0.5, 100, 0, 1)
  -- step = (1-0)/100 = 0.01
  -- v = (floor(0.5/0.01 + 0.5) - 1) * 0.01 = (50 - 1) * 0.01 = 0.49
  lu.assertAlmostEquals(v, 0.49, 0.001)
end

function TestUtilFunctions:test_increase_at_max()
  local v = util.increase(1.0, 100, 0, 1)
  lu.assertEquals(v, 1)
end

function TestUtilFunctions:test_reduce_at_min()
  local v = util.reduce(0.0, 100, 0, 1)
  lu.assertEquals(v, 0)
end

return TestColorConversion

