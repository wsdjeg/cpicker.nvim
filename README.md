# cpicker.nvim

> _cpicker.nvim_ is a Color Converter for neovim.

[![GitHub License](https://img.shields.io/github/license/wsdjeg/cpicker.nvim)](LICENSE)
[![GitHub Issues or Pull Requests](https://img.shields.io/github/issues/wsdjeg/cpicker.nvim)](https://github.com/wsdjeg/cpicker.nvim/issues)
[![GitHub commit activity](https://img.shields.io/github/commit-activity/m/wsdjeg/cpicker.nvim)](https://github.com/wsdjeg/cpicker.nvim/commits/master/)
[![GitHub Release](https://img.shields.io/github/v/release/wsdjeg/cpicker.nvim)](https://github.com/wsdjeg/cpicker.nvim/releases)

<!-- vim-markdown-toc GFM -->

- [Intro](#intro)
- [Install](#install)
- [Commands](#commands)
- [Key binding](#key-binding)
- [Feedback](#feedback)

<!-- vim-markdown-toc -->

## Intro

cpicker.nvim is a lightweight color palette plugin for Neovim that supports a wide range of color models,
such as HEX, RGB, HSL, HSV, CMYK, HWB, Lab, Linear RGB, XYZ, and more.
Support for additional color spaces will be added in future releases.

## Install

Use your preferred Neovim plugin manager to install cpicker.nvim.

with [nvim-plug](https://github.com/wsdjeg/nvim-plug)

```lua
require("plug").add({
	{ "wsdjeg/cpicker.nvim", depends = {
		{ "wsdjeg/logger.nvim" },
		{ "wsdjeg/notify.nvim" },
	} },
})
```

Then use `:PlugInstall cpicker.nvim` to install this plugin.

## Commands

1. `:Cpicker`: open the color converter
2. `:CpickerCursorForeground`: open the color converter with cursor highlight
3. `:CpickerColorMix`: open the color mixer
4. `:CpickerCursorChangeHighlight`: change the highlight of cursor word
5. `:CpickerClearColorPatch`: clear colorscheme patch

## Key binding

| key binding      | description |
| ---------------- | ----------- |
| `h` or `<Left>`  | reduce      |
| `l` or `<Right>` | increase    |

## Feedback

If you encounter any bugs or have suggestions, please file an issue in the [issue tracker](https://github.com/wsdjeg/cpicker.nvim/issues)
