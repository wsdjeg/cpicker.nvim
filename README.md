# cpicker.nvim

> _cpicker.nvim_ is a Color Converter for neovim.

[![GitHub License](https://img.shields.io/github/license/wsdjeg/cpicker.nvim)](LICENSE)
[![GitHub Issues or Pull Requests](https://img.shields.io/github/issues/wsdjeg/cpicker.nvim)](https://github.com/wsdjeg/cpicker.nvim/issues)
[![GitHub commit activity](https://img.shields.io/github/commit-activity/m/wsdjeg/cpicker.nvim)](https://github.com/wsdjeg/cpicker.nvim/commits/master/)
[![GitHub Release](https://img.shields.io/github/v/release/wsdjeg/cpicker.nvim)](https://github.com/wsdjeg/cpicker.nvim/releases)

<!-- vim-markdown-toc GFM -->

- [Intro](#intro)
- [Install](#install)
- [Usage](#usage)
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
require('plug').add({
    {
        'wsdjeg/cpicker.nvim',
        depends = {
            { 'wsdjeg/logger.nvim' },
            { 'wsdjeg/notify.nvim' },
        },
    },
})
```

Then use `:PlugInstall cpicker.nvim` to install this plugin.

## Usage

1. open color palette with specific color models.

```
:Cpicker rgb hsl
```

2. open color palette with cursor highlight

```
:CpickerCursorForeground
```

3. open color mixer:

```
:CpickerColorMix #282828 #23EF12
```

4. Change the highlight of cursor position. This command will generate colorscheme patch which will be loaded when using same colorscheme.

```
:CpickerCursorChangeHighlight
```

Use `:CpickerClearColorPatch` command to clear colorscheme patch

## Key binding

| key binding      | description |
| ---------------- | ----------- |
| `h` or `<Left>`  | reduce      |
| `l` or `<Right>` | increase    |
| `<Enter>`        | copy        |

## Feedback

If you encounter any bugs or have suggestions, please file an issue in the [issue tracker](https://github.com/wsdjeg/cpicker.nvim/issues)
